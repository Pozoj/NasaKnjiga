class Translation < ActiveRecord::Base
  belongs_to :page_kind  
  validates_presence_of :page_kind
  
  def strings
    attributes.reject {|a,v| v.blank? or a =~ /id/ or a =~ /at/ }.values.join(", ") # LOL
  end
end
