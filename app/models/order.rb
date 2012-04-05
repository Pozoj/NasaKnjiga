class Order < ActiveRecord::Base
  belongs_to :page
  belongs_to :pickup
  belongs_to :post
  belongs_to :photo, :dependent => :destroy
  has_many :photos, :as => :photographable, :dependent => :destroy
  
  validates_presence_of :name, :surname, :street, :street_number, :post_id, :quantity, :page, :photo
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_nil => true, :allow_blank => true
  validates_presence_of :vat_id, :if => Proc.new { |order| order.company? }, :message => "mora biti izpolnjeno, če je navedeno podjetje."
  validates_presence_of :company, :if => Proc.new { |order| order.vat_id? }, :message => "mora biti izpolnjeno, če je izpolnjen ID za DDV."
  validates_numericality_of :quantity, :street_number

  named_scope :published, :conditions => ["pages.published = ?", true], :include => :page

  accepts_nested_attributes_for :photos

  before_save :calculate_totals, :associate_photos
  
  attr_writer :price
  
  cattr_reader :tax_for_books
  @@tax_for_books = 0.085
  
  def address
    "#{street} #{street_number}#{street_suffix}" if street and street_number
  end
  
  def address?
    !!address
  end
  
  def full_address
    "#{address}, #{post.id} #{post.name}" if address? and post
  end
  
  def full_address?
    !!full_address
  end
  
  def full_name
    full_name = "#{name} #{surname}"
    full_name += " (#{company})" if company?
    full_name
  end
  
  def to_s
    "Naročilo ##{id}"
  end
  
  def price
    @price ||= if page.book.prices and not page.book.prices.empty?
      if exact_price = page.book.prices.find_by_quantity(quantity)
        exact_price.price_without_tax
      elsif exact_price = page.book.prices.default.first
        exact_price.price_without_tax
      end
    else
      0.0
    end
  end
  
  def price?
    !!price
  end
  
  def price_with_discount
    if discount?
      price - (price * discount_fraction)
    else
      price
    end
  end
  
  def price_with_discount?
    !!price_with_discount
  end
  
  def tax_per_book?
    !!tax_per_book
  end
  
  def tax_per_book
    price_with_discount * tax_for_books
  end
  
  def discount_fraction
    discount / 100.0
  end
  
  def calculate_totals
    self.subtotal = price_with_discount * quantity
    self.tax = tax_per_book * quantity
    self.total = subtotal + tax
  end

  private
  
	def associate_photos
	  if photo
  	  self.photos << photo unless photos.include?(photo)
	  end
	  photos.each { |photo| photo.photographable = self }
	end
end
