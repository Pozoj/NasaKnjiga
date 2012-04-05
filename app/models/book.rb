class Book < ActiveRecord::Base
  has_many :sections, :order => "position", :dependent => :destroy
  has_many :pages, :through => :sections
  has_many :prices, :dependent => :destroy, :order => "quantity"
  belongs_to :kind, :class_name => "BookKind"
  
  accepts_nested_attributes_for :prices, :allow_destroy => true

  before_validation_on_create :initialize_prices
  before_validation :create_subdomain

  validates_presence_of :kind_id, :title
  validates_presence_of :subdomain, :if => Proc.new { |book| book.title? }
  validates_uniqueness_of :subdomain, :case_sensitive => false, :if => Proc.new { |book| book.title? }
  validates_format_of :subdomain, :with => /^[a-zA-z0-9]+[a-zA-z0-9-]*[a-zA-z0-9]+$/, :if => Proc.new { |book| book.title? }
  validates_length_of :subdomain, :within => 3..32, :if => Proc.new { |book| book.title? }
  validates_exclusion_of :subdomain, :in => %w( www ), :message => "Poddomena <strong>{{value}}</strong> je rezervirana in ni na voljo.", :if => Proc.new { |book| book.title? }
  
  # Scopes
  named_scope :published, :conditions => ["published = ?", true]
  
  # Cover
  has_attached_file :cover, :styles => { :small => "100x100>", :shelf => "240x240>" },
                    :url  => "/assets/books/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/books/:id/:style/:basename.:extension"
  
  formats_attributes :about

  def worth
    @worth ||= orders.map(&:total).inject(0) { |sum, ammount| sum + ammount }
  end
  
  def quantity
    @quantity ||= orders.map(&:quantity).inject(0) { |sum, ammount| sum + ammount }    
  end
  
  def authorize(_password)
    _password == password
  end
  
  def orders
    @orders ||= pages.map(&:orders).flatten
  end
  
  def to_param
    subdomain
  end
  
  def to_s
    title
  end
  
  private
  
  def create_subdomain
    _subdomain = subdomain?? subdomain.make_websafe : title.make_websafe
    
    if new_record?
      counter = 1
      while Book.count(:conditions => ["subdomain = ?", _subdomain]) > 0
        _subdomain = self.title.make_websafe + "-#{counter}"
        counter += 1
      end
    end
    
    self.subdomain = _subdomain
  end
  
  def initialize_prices
    prices.each { |c| c.book = self }
  end
end
