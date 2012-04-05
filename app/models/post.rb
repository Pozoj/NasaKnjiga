class Post < ActiveRecord::Base
  has_many :pages
  
  validates_presence_of :name
  
  def to_s
    name
  end
end
