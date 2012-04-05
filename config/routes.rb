ActionController::Routing::Routes.draw do |map|
  
  # Subdomain dependent routes
  map.with_options :conditions => { :subdomain => /^[A-Za-z0-9-]+$/ } do |subdomain|
    subdomain.resources :sections, :as => "sekcije", :collection => {:stats => :get, :try_export => :get, :export_photos => :get} do |section|
      section.resources :pages, :as => "strani", :collection => {:missing => :get}, :member => {:preview => :get}
    end
    
    subdomain.resources :pages, :as => "strani", :collection => {:search => :get, :export => :get} do |page|
      page.resources :photos, :as => "fotografije", :only => [:new, :create, :destroy]
      page.resources :orders, :as => "narocila", :collection => {:calculation => :get, :print => :get}, :member => {:calculation => :get}
    end
    
    subdomain.resources :orders, :as => "narocila", :collection => {:export => :get, :print => :get} do |order|
      order.resources :photos, :as => "fotografije", :only => [:new, :create, :destroy]
    end
    
    subdomain.root :controller => :sections
  end
  
  # Subdomain independent routes
  map.with_options :conditions => { :subdomain => false } do |domain|
    domain.resources :book_kinds, :as => "tipi_knjig" do |book_kind|
      book_kind.resources :page_kinds, :as => "tipi_strani", :except => :index
    end
    domain.resources :users, :as => "uporabniki" do |user|
      user.resources :permissions, :as => "dovoljenja"
      user.resources :photos, :as => "fotografije", :only => [:new, :create, :destroy]
    end
    domain.resources :books, :member => {:authorize => :get, :authorize_process => :post}, :as => "knjige" do |book|
      book.resources :prices, :as => "cene"
    end

    domain.resources :pickups, :as => "mesta_prevzemov"
    domain.resources :orders, :as => "narocila"
    
    domain.index "", :controller => :books

    domain.resource :session, :except => [:edit, :update], :subdomain => false
  end
  
  # Static
  map.with_options :controller => :static do |static|
    static.contact '/kontakt', :action => :contact
    static.about '/o-storitvi', :action => :about
  end
  
  # Special blank resource upload path.
  map.resources :photos, :only => :create
  map.sections_sort '/knjige/:id/sort', :controller => :books, :action => :sort
end
