class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :kind_id
      t.string :email
      t.string :password_hash
      t.string :name
      t.string :surname      

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
