class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  belongs_to :page
  
  validates_presence_of :user
  
  def self.create_all(permissions)
    permissions.each do |id, p| 
      if p[:book_id]
        self.create :book_id => p[:book_id]
      elsif not p[:page_ids].empty?
        p[:page_ids].values.each { |p| self.create :page_id => p}
      end
    end
      
  end
end