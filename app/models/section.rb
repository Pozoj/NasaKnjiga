class Section < ActiveRecord::Base
  belongs_to :book
  has_many :pages, :dependent => :destroy
  
  default_scope :order => "book_id, position"
  
  validates_presence_of :name, :permalink, :book
  
  before_validation :create_permalink
  
  
  def to_param
    "#{id}-#{permalink}"
  end

  def to_s
    name
  end
  
  private
  
  def create_permalink
    self.permalink = name?? name.make_websafe : "sekcija"
  end
end
