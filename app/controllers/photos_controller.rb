class PhotosController < InheritedResources::Base
  belongs_to :page, :order, :polymorphic => true, :optional => true
  before_filter :set_js_format
    
  def create
    create! do |format|
      format.html
      format.js
    end
  end
  
  def destroy
    destroy! { section_page_path(@page.section, @page) }
  end
  
  def set_js_format
    request.format = :js if params["X-Progress-ID"]
  end

end
