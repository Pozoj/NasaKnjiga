class Price < ActiveRecord::Base
  belongs_to :book
  validates_presence_of :book, :price_without_tax
  
  named_scope :default, :conditions => ["prices.quantity IS ? OR prices.quantity = ?", nil, 0], :limit => 1

  attr_writer :default_quantity
  
  def default_quantity
    !quantity or quantity.blank? or quantity.zero?
  end
end
