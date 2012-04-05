class CreateUserTypes < ActiveRecord::Migration
  def self.up
    create_table :user_kinds do |t|
      t.string :name
      t.string :kind

      t.timestamps
    end
  end

  def self.down
    drop_table :user_types
  end
end
