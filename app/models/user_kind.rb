class UserKind < ActiveRecord::Base
  has_many :users, :foreign_key => "type_id"
  
  def to_s
    name
  end
end
