# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110404180357) do

  create_table "book_kinds", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", :force => true do |t|
    t.integer  "kind_id"
    t.string   "title"
    t.string   "subdomain"
    t.boolean  "published",          :default => false
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "email",              :default => "info"
    t.text     "about"
    t.text     "about_html"
    t.integer  "rows"
    t.integer  "cols"
  end

  create_table "orders", :force => true do |t|
    t.string   "book_title"
    t.string   "company"
    t.string   "name"
    t.string   "surname"
    t.string   "street"
    t.integer  "street_number"
    t.string   "street_suffix"
    t.integer  "post_id"
    t.string   "phone"
    t.string   "email"
    t.integer  "page_id"
    t.integer  "pickup_id"
    t.integer  "quantity",      :default => 1
    t.decimal  "subtotal"
    t.decimal  "total"
    t.decimal  "tax"
    t.integer  "discount",      :default => 0
    t.datetime "shipped_at"
    t.string   "vat_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_kinds", :force => true do |t|
    t.string   "name"
    t.text     "page_fields"
    t.integer  "book_kind_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "section_id"
    t.string   "title"
    t.string   "subtitle"
    t.string   "street"
    t.integer  "street_number"
    t.string   "street_suffix"
    t.integer  "post_id"
    t.string   "phone"
    t.string   "mobile"
    t.boolean  "mobile_published", :default => false
    t.string   "email"
    t.boolean  "email_published",  :default => false
    t.string   "website"
    t.integer  "kind_id"
    t.text     "body"
    t.text     "body_html"
    t.text     "body_original"
    t.string   "contact_name"
    t.string   "contact_surname"
    t.string   "data_from"
    t.integer  "owner_id"
    t.boolean  "printed"
    t.text     "notes"
    t.boolean  "published",        :default => false
    t.boolean  "reviewed",         :default => false
    t.datetime "reviewed_at"
    t.text     "reviewer_notes"
    t.integer  "reviewer_id"
    t.integer  "photo_id"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "phone_published"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "page_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "photographable_id"
    t.string   "photographable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "pickups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prices", :force => true do |t|
    t.integer  "book_id"
    t.integer  "quantity"
    t.decimal  "price_without_tax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.integer  "position",   :default => 0
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", :force => true do |t|
    t.integer  "page_kind_id"
    t.string   "title"
    t.string   "subtitle"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_kinds", :force => true do |t|
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "kind_id"
    t.string   "email"
    t.string   "password_hash"
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
