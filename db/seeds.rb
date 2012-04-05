UserKind.create([
  {:name => "Administrator", :kind => "admin"},
  {:name => "Lektor", :kind => "reviewer"},
  {:name => "Urednik", :kind => "editor"},
  {:name => "Oblikovalec", :kind => "designer"}
  ])
  
User.create(:name => "Admin", :surname => "Administrator", :email => "admin@localhost.com", :password => "admin", :kind_id => 1)
User.create(:name => "Lektor", :surname => "Lektorant", :email => "lektor@localhost.com", :password => "lektor", :kind_id => 2)
User.create(:name => "Uredi", :surname => "Urednik", :email => "urednik@localhost.com", :password => "urednik", :kind_id => 3)
User.create(:name => "Oblika", :surname => "Oblikovalec", :email => "oblikovalec@localhost.com", :password => "oblikovalec", :kind_id => 4)

book_kind = BookKind.create(:name => "Moj Kraj")
book = Book.create(:kind => book_kind, :title => "Vinska Gora", :subdomain => "vinska-gora", :published => true)
section = Section.create(:name => "Zaselek", :book => book)
Price.create(:price_without_tax => 55.00, :book => book, :quantity => 1)
Price.create(:price_without_tax => 50.00, :book => book, :quantity => 2)
Price.create(:price_without_tax => 45.00, :book => book, :quantity => 3)
Price.create(:price_without_tax => 40.00, :book => book, :quantity => 4)
Price.create(:price_without_tax => 35.00, :book => book)
page_kind = PageKind.create(:book_kind => book_kind, :name => "Domačija", :page_fields => "address, phone, mobile, email, website")
page = Page.create(:section => section, :kind => page_kind, :title => "Pri Reberniku", :street => "Pirešica", :street_number => "2", :phone => "(041) 627-915", :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
page = Page.create(:section => section, :kind => page_kind, :published => true, :title => "Pri Johanu", :street => "Efenkova", :street_number => "2", :phone => "(041) 627-915", :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
order = Order.create(:book_title => "Pri Pušjeku", :name => "Simon", :surname => "Talek", :street => "Pirešica", :street_number => "2", :phone => "(041) 627-915", :quantity => 5, :page => page)

