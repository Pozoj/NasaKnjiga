class AddDecimalPlacesToPrices < ActiveRecord::Migration
  def self.up
    change_column :prices, :price_without_tax, :decimal, :scale => 2, :precision => 8
    change_column :orders, :subtotal, :decimal, :scale => 2, :precision => 8
    change_column :orders, :total, :decimal, :scale => 2, :precision => 8
    change_column :orders, :tax, :decimal, :scale => 2, :precision => 8
  end

  def self.down
    change_column :prices, :price_without_tax, :string
  end
end