class BookKind < ActiveRecord::Base
  has_many :books, :foreign_key => "kind_id"
  has_many :page_kinds
  
  validates_presence_of :name
  
  def to_s
    name
  end
end
