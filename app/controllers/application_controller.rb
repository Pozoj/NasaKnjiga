class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_book, :current_book?, :body_attrs, :generate_uuid
  before_filter :validate_book
  
  protect_from_forgery
  include Authentication
  
  def current_book
    @current_book ||= Book.find_by_subdomain current_subdomain
  end
  
  def current_book?
    !!current_book
  end
  
  def validate_book
   unless current_subdomain.nil?
     unless current_book?
       flash[:error] = "Knjiga ne obstaja!"
       redirect_to root_url(:subdomain => false)
     end
   end
  end
  
  def require_book
    unless current_book?
      flash[:error] = "Manjkajo zahtevani podatki!"
      redirect_to root_url(:subdomain => false)
    end
  end
  
  def generate_uuid
    (0..29).to_a.map {|x| rand(10)}.to_s
  end
  
  def body_attrs
   { :class => controller_name, :id => "#{controller_name}-#{action_name}" }
  end
end
