require 'zip/zipfilesystem'

class SectionsController < InheritedResources::Base
  before_filter :authenticate_admin, :only => [:stats]
  before_filter :authenticate_edit, :except => [:index, :new, :create, :export_photos]
  before_filter :authenticate_editor, :only => [:new, :create]
  before_filter :authenticate_designer, :only => [:export_photos]
  before_filter :restrict_unpublished_books, :only => [:index, :show]
  before_filter :require_book

  def create
    create! { root_path(:subdomain => resource.book.subdomain) }
  end
  
  def update
    update! { section_pages_path resource }
  end
  
  def try_export
    @orders = current_book.orders
    @orders_without_photos = @orders.reject { |order| order.photo and order.photo.photo and order.photo.photo.file? and File.file?(order.photo.photo.path(:print)) }
  end
  
  def export_photos
    @archive_name = "#{current_book.title[0,15].make_websafe}"
    @archive_path = File.join Rails.root, "public", "assets", "export", "#{@archive_name}.zip"
    
    # Get all photos.
    @orders = current_book.orders
    
    # Init fail counter.
    @fail_count = 0
    
    # If archive exists, remove it.
    if File.file?(@archive_path)
      File.delete(@archive_path)
    end
    
    # Init excel spreadsheet.
    @excel = Spreadsheet::Workbook.new
    @sheet1 = @excel.create_worksheet
    @sheet1.row(0).push "NazivFoto"
    @sheet1.row(0).push "NaslovKnjige"
    @sheet1.row(0).push "Ulica"
    @sheet1.row(0).push "UlSt"
    @sheet1.row(0).push "UlPrip"
    
    unless @orders.empty?
      # In a separate process do the thing.
      spawn do
        @zip_status = Zip::ZipFile.open(@archive_path, Zip::ZipFile::CREATE) do |zip|
          @orders.each_with_index do |order, idx|
            path = order.photo.photo.path(:print)
        
            # If the file exists, add it to the ZIP.
            if File.file?(path)
              # Push to spreadsheet.
              @sheet1.row(idx+1).push order.photo.short_name
              @sheet1.row(idx+1).push order.book_title
              @sheet1.row(idx+1).push order.page.street
              @sheet1.row(idx+1).push order.page.street_number
              @sheet1.row(idx+1).push order.page.street_suffix
              
              # Push image to ZIP.
              zip.add("#{@archive_name}/#{order.photo.short_name}", path)
            else
              @orders.delete order
              @fail_count += 1
            end
          end
    
          # Save excel to tmp.
          save_to = File.join(Rails.root, "tmp", "temp.xls")
          # If spreadhseet exists, remove it.
          if File.file?(save_to)
            File.delete(save_to)
          end
          @excel.write(save_to)
          
          # And add to ZIP file.
          zip.add("#{@archive_name}/#{@archive_name}_tabela.xls", save_to)
        end
    
        # Set read permissions on the file
        File.chmod(0644, @archive_path)
      end
    end
  end

  protected
  
  def begin_of_association_chain
    current_book
  end
  
  def authenticate_edit
    if current_user?
      return if current_user.admin?
      editor_error if !current_user.editor? or !can_edit?(resource) # When creating we don't have the resource, just the current book.
    end
  end

end
