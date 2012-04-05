class BooksController < InheritedResources::Base
  before_filter :authenticate_admin, :except => [:index, :authorize, :authorize_process]
  
  def new
    @book = Book.new
    @book.prices.build(:quantity => 1)
    @book.prices.build
  end
  
  def create
    create! { books_path }
  end

  def authorize_process
    if params[:password] and resource.authorize(params[:password])
      session["book_#{resource.id}_authorization"] = true
      flash[:notice] = "Dostop do knjige je dovoljen."
      
      go_back = session[:go_back]
      session[:go_back] = nil
      redirect_to go_back ? go_back : book_pages_path(resource)
    else
      flash[:error] = "Geslo za dostop do knjige ni pravilno!"
      render :action => "authorize"
    end
  end
  
  def sort
    if params[:sections_list]
      params[:sections_list].each_with_index do |id, index|
        Section.update_all(['position=?', index+1], ['id=?', id])
      end
    end
    render :nothing => true
  end
  
  private
  
  def resource
    @book ||= current_book?? current_book : Book.find_by_subdomain(params[:id]) 
  end
  
  def collection
    @books = current_user?? end_of_association_chain.all : end_of_association_chain.published
  end
end
