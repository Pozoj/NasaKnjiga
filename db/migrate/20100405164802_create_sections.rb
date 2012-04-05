class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :name
      t.string :permalink
      t.integer :position, :default => 0
      t.integer :book_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
