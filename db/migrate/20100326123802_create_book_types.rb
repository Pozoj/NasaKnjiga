class CreateBookTypes < ActiveRecord::Migration
  def self.up
    create_table :book_kinds do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :book_types
  end
end
