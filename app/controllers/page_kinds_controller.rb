class PageKindsController < InheritedResources::Base
  before_filter :authenticate_admin
  belongs_to :book_kind
  
  def create
    create! { book_kind_path(@book_kind) }
  end
  
  def destroy
    destroy! { book_kind_path(@book_kind) }
  end
  
  def new
    new! do
      resource.build_translation
    end
  end
end
