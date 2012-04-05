class OrdersController < InheritedResources::Base
  before_filter :authenticate_admin, :only => [:index, :destroy]
  belongs_to :page, :optional => true
  
  def new
    new! do
      if @page
        @order.name = @page.contact_name
        @order.surname = @page.contact_surname
        @order.email = @page.email
        @order.phone = @page.phone
        @order.street = @page.street
        @order.street_number = @page.street_number
        @order.street_suffix = @page.street_suffix
        @order.post_id = @page.post_id
        @order.book_title = @page.title
        @order.photo = @page.photo
        @order.calculate_totals
      end
    end
  end
  
  def export
    render :layout => false
  end
  
  def create
    create! do
      resource.photo = resource.photos.first unless resource.photos.empty?
      resource.save
      resource_path
    end
  end
  
  def calculation
    if (params[:id] and resource = Order.find(params[:id])) or (collection and resource = @page.orders.build)
      if params[:quantity] and params[:discount]
        resource.discount = params[:discount]
        resource.quantity = params[:quantity]
        resource.calculate_totals
        render :partial => "orders/calculation_small", :locals => {:resource => resource}, :layout => false
      else
        render :nothing => true
      end
    end
  end
  
  def print
    @date = params[:date] ? Date.civil(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i) : Date.today
    if params[:order_id] and not params[:order_id].blank?
      @orders = [Order.find(params[:order_id])]
    else
      @orders = current_book.orders.reject { |order| order.page.nil? or (order.page and !order.page.published?) }
    end
  end
  
  protected
  
  def collection
    if @page
      orders = @page.orders
    elsif current_book
      orders = current_book.orders
    else
      orders = Order.all
    end
    
    @orders = orders.reject { |order| order.page.nil? }
  end
end
