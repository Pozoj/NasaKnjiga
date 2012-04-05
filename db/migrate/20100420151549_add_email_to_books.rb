class AddEmailToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :email, :string, :default => "info"
    add_column :books, :about, :text
    add_column :books, :about_html, :text
  end

  def self.down
    remove_column :books, :about
    remove_column :books, :email
  end
end
