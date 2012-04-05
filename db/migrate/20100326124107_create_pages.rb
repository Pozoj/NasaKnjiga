class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.integer :section_id
      t.string :title
      t.string :subtitle
      t.string :street
      t.integer :street_number
      t.string :street_suffix
      t.integer :post_id
      t.string :phone
      t.string :mobile
      t.boolean :mobile_published, :default => false
      t.string :email
      t.boolean :email_published, :default => false
      t.string :website
      t.integer :kind_id
      t.text :body
      t.text :body_html
      t.text :body_original
      t.string :contact_name
      t.string :contact_surname      
      t.string :data_from
      t.integer :owner_id
      t.boolean :printed
      t.text :notes
      t.boolean :published, :default => false
      t.boolean :reviewed, :default => false
      t.datetime :reviewed_at
      t.text :reviewer_notes
      t.integer :reviewer_id
      t.integer :photo_id
      t.string :permalink
      

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
