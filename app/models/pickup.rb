class Pickup < ActiveRecord::Base
  has_many :orders
  
  validates_presence_of :name
  
  def to_s
    name
  end
end
