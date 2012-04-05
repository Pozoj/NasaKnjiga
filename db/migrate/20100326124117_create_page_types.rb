class CreatePageTypes < ActiveRecord::Migration
  def self.up
    create_table :page_kinds do |t|
      t.string :name
      t.text :page_fields
      t.integer :book_kind_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :page_types
  end
end
