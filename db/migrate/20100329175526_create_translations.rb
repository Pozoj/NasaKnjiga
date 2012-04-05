class CreateTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations do |t|
      t.integer :page_kind_id
      
      t.string :title
      t.string :subtitle
      t.string :body
      
      t.timestamps
    end
  end

  def self.down
    drop_table :translations
  end
end
