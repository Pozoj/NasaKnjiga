class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.integer :kind_id
      t.string :title
      t.string :subdomain
      t.boolean :published, :default => false
      t.string :password

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
