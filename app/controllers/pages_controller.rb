class PagesController < InheritedResources::Base
  belongs_to :section, :optional => nil
  before_filter :authenticate_edit, :only => [:edit, :update];
  before_filter :authenticate_destroy, :only => :destroy
  before_filter :authenticate_editor, :only => [:new, :create]
  before_filter :restrict_unpublished_books, :only => [:index, :show]
  before_filter :require_book
  
  def new
    new! do
      resource.kind_id = params[:kind_id] if params[:kind_id]
      resource.photos.build
    end
  end
  
  def edit
    edit! do
      if reviewer? and not resource.body_original?
        resource.body_original = resource.body
      end
    end
  end
  
  def create
    create! do
      resource.photo = resource.photos.first unless resource.photos.empty?
      resource.save
      resource_path
    end
  end
  
  def export
    @pages = current_book.pages :order => "section_id, street_name, street_number, street_suffix"
    render :layout => false
  end
  
  def search
    @pages = current_book.pages.search params[:q], !(current_user and current_user.admin?)
  end
  
  def missing
    @missing_street_numbers = parent.pages.missing
  end
  
  def preview
    resource.title = params[:title]
  end
  
  
  private
  
  def collection
    @pages ||= if editor?
      end_of_association_chain.ordered(params[:order])
    elsif designer?
      end_of_association_chain.published.ordered(params[:order])
    else
      end_of_association_chain.published
    end
  end
  
  def authenticate_edit
    if current_user?
      return if current_user.admin?
      editor_or_reviewer_error if !(current_user.editor? or current_user.reviewer?) or !can_edit?(resource)
    end
  end
  
  def authenticate_destroy
    if current_user?
      return if current_user.admin?
      editor_error if !current_user.editor? or !can_edit?(resource)
    end
  end
  
  def authenticate_editor
    if current_user?
      return if current_user.admin?
      editor_error if !current_user? or !current_user.editor? or !can_edit?(current_book)
    end
  end

end
