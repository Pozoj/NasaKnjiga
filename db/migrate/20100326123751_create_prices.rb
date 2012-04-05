class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.integer :book_id
      t.integer :quantity
      t.decimal :price_without_tax

      t.timestamps
    end
  end

  def self.down
    drop_table :prices
  end
end
