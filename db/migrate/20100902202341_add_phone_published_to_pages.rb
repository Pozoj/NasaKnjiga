class AddPhonePublishedToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :phone_published, :boolean
  end

  def self.down
    remove_column :pages, :phone_published
  end
end
