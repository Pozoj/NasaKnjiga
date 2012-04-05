class Page < ActiveRecord::Base
  belongs_to :section
  has_one :book, :through => :section
  belongs_to :kind, :class_name => "PageKind"
  belongs_to :post
  belongs_to :owner, :class_name => "User"
  belongs_to :reviewer, :class_name => "User"
  belongs_to :photo, :dependent => :destroy
  has_many :photos, :as => :photographable, :dependent => :destroy
  has_many :orders do
    def worth
      sum "total"
    end
    
    def quantity
      sum "quantity"
    end
  end
  
  accepts_nested_attributes_for :photos

  before_validation :uri_normalize, :create_permalink
  before_validation_on_create :associate_photos
    
  validates_presence_of :title, :kind, :section, :body
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_nil => true, :allow_blank => true
  validates_format_of :website, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, :allow_nil => true, :allow_blank => true
  validates_numericality_of :street_number, :allow_nil => true, :allow_blank => true
  
  named_scope :published, :conditions => ["published = ?", true]
  
  formats_attributes :body
    
  def attributes_allowed
    kind.page_fields.keys
  end
  
  def field_wanted?(field)
    if kind and kind.page_fields
      kind.page_fields.include? field.to_s
    end
  end
  
  def field(name)
    kind.field_name(name) if kind
  end
  
  def address
    if street and street_number and post_id
      "#{street} #{street_number}#{street_suffix}, #{post_id} #{post}"
    end
  end
  
  def book_title
    "#{book.kind} - #{book} (#{kind})"
  end
  
  def to_param
    "#{id}-#{permalink}"
  end
    
  def to_s
    title
  end
  
  def other_photos
    photos.reject { |p| p == photo }
  end
  
  def self.search(term, published = false)
    if published
      all :conditions => ["(pages.title LIKE :search OR pages.subtitle LIKE :search) AND (pages.published = :published)", {:search => "%#{term}%", :published => true}]
    else
      all :conditions => ["pages.title LIKE :search OR pages.subtitle LIKE :search", {:search => "%#{term}%"}]
    end
  end
  
  def self.ordered(order="")
    if order
      # Whitelist of order fields.
      allowed_ordered = ["id", "title", "street", "street_number", "photo_id", "published", "printed"]
      plain_order = order.gsub(/_\z/, "")
    
      if allowed_ordered.include?(plain_order)
        order = order.gsub(/_\z/, " DESC") if order =~ /_$/
        if plain_order == "street_number"
          order = "street, #{order}"
        end
      
        return find :all, :order => order
      end
    end
    all
  end
  
  def self.missing
    numbers = all.map(&:street_number).sort.uniq
    all_numbers = Array.new(numbers[numbers.size-1]).fill { |n| n += 1 }
    missing = all_numbers.reject { |n| numbers.include?(n) }
  end
  
  private
  
  def create_permalink
    self.permalink = title.make_websafe if title?
  end
  
  def uri_normalize
    if website?
    	self.website = 'http://' + website unless website =~ /http:\/\//
  	end
	end
	
	def associate_photos
	  if photo
  	  self.photos << photo unless photos.include?(photo)
	  end
	  photos.each { |photo| photo.photographable = self }
	end
end