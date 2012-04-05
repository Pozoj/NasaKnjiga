class CreateTablePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions, :force => true do |t|
      t.integer :user_id
      t.integer :page_id
      t.integer :book_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end
