Given /^(?:I am|I'm) logged in as an admin$/ do 
  user = Factory.create :user, :kind => Factory(:user_kind, :kind => "admin")
  post session_path, :user => {:email => user.email, :password => user.password}
  response.should be_redirect
end

Given /^(?:I am|I'm) logged in as a reviewer$/ do 
  user = Factory.create :user, :kind => Factory(:user_kind, :kind => "reviewer")
  post session_path, :user => {:email => user.email, :password => user.password}
  response.should be_redirect
end

Given /^(?:I am|I'm) logged in as a reviewer for the book "(.*)"$/ do |book|
  book = Book.find_by_title book
  user = Factory.create :user, :kind => Factory(:user_kind, :kind => "reviewer")
  user.permissions << Permission.new(:book => book)
  post session_path, :user => {:email => user.email, :password => user.password}
  response.should be_redirect
end

Given /^(?:I am|I'm) logged in as an editor$/ do 
  user = Factory.create :user, :kind => Factory(:user_kind, :kind => "editor")
  post session_path, :user => {:email => user.email, :password => user.password}
  response.should be_redirect
end

Given /^(?:I am|I'm) logged in as an editor for the book "(.*)"$/ do |book|
  book = Book.find_by_title book
  user = Factory.create :user, :kind => Factory(:user_kind, :kind => "editor")
  user.permissions << Permission.new(:book => book)
  post session_path, :user => {:email => user.email, :password => user.password}
  response.should be_redirect
end

Given /^(?:I am|I'm) logged in as an editor for the page "(.*)"$/ do |page|
  page = Page.find_by_title page
  user = Factory.create :user, :kind => Factory(:user_kind, :kind => "editor")
  user.permissions << Permission.new(:page => page)
  post session_path, :user => {:email => user.email, :password => user.password}
  response.should be_redirect
end

Given /^(?:I am|I'm) logged in as a designer$/ do 
  user = Factory.create :user, :kind => Factory(:user_kind, :kind => "designer")
  post session_path, :user => {:email => user.email, :password => user.password}
  response.should be_redirect
end

Given /^I log in with "(.*)" and password "(.*)"$/ do |email, password|
  post session_path, :user => {:email => email, :password => password}
  response.should be_redirect
end

Then /^I logout$/ do
  delete session_path
  response.should be_redirect
end
