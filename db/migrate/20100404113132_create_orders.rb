class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :book_title
      t.string :company
      t.string :name
      t.string :surname
      t.string :street
      t.integer :street_number
      t.string :street_suffix
      t.integer :post_id
      t.string :phone
      t.string :email
      t.integer :page_id
      t.integer :pickup_id
      t.integer :quantity, :default => 1
      t.decimal :subtotal
      t.decimal :total
      t.decimal :tax
      t.integer :discount, :default => 0
      t.datetime :shipped_at
      t.string :vat_id
      t.integer :photo_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
