Factory.define :user do |u|
  u.sequence(:name) { |n| "Peter#{n}"}
  u.sequence(:surname) { |n| "Morbert#{n}"}
  u.email {|a| "#{a.name}.#{a.surname}@example.com".downcase }
  u.password "peter"
  u.association :kind, :factory => :user_kind
end

Factory.define :permission do |p|
  p.association :user
  p.association :book
  p.association :page
end

Factory.define :user_kind do |uk|
  uk.name "Administrator"
  uk.kind "admin"
end

Factory.define :book_kind do |bk|
  bk.name "Moj kraj"
end

Factory.define :book do |b|
  b.association :kind, :factory => :book_kind
  b.title "Vinska Gora"
  b.email "vg"
  b.about "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  b.published true
  b.password "vinskagora"
end

Factory.define :page_kind do |pk|
  pk.name "Some Kind"
  pk.page_fields "subtitle, address"
  pk.association :book_kind
end

Factory.define :photo do |p|
  # p.association :photographable, :factory => :page
end

Factory.define :section do |s|
  s.name "Zaselek 1"
  s.association :book, :factory => :book
end

Factory.define :page do |p|
  p.title "Simon Talek"
  p.body "Lol"
  p.association :section, :factory => :section
  p.association :kind, :factory => :page_kind
  p.association :post
end

Factory.define :pickup do |p|
  p.name "Župnišče"
end

Factory.define :order do |o|
  o.company "MO Velenje"
  o.name "Srečko"
  o.surname "Meh"
  o.street "Titov trg"
  o.street_number 1
  o.vat_id "SI123214521"
  o.phone "(03) 897 22 20"
  o.email "info@velenje.si"
  o.quantity 3
  o.book_title "Lol Kraj"
  o.association :pickup
  o.association :page
  o.association :post
  o.association :photo
end
  

Factory.define :post do |p|
  p.name "Velenje"
end

Factory.define :price do |p|
  p.association :book
  p.sequence(:quantity) { |n| n }
  p.price_without_tax { |price| price.quantity * 50.45 }
end