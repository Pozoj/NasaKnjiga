class AddRowsAndColumnsToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :rows, :integer
    add_column :books, :cols, :integer
  end

  def self.down
    remove_column :books, :cols
    remove_column :books, :rows
  end
end
