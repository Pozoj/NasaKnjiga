Then(/^I should see the pages table$/) do |expected_table|  
  expected_table.diff!(table_at("#pages").to_a)  
end

Given /^I fill in the page fields$/ do
  Then 'I fill in "page[title]" with "Lorem Ipsum"'
  Then 'I fill in "page[subtitle]" with "Bablija"'
  Then 'I fill in "page[body]" with "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."'
  Then 'I fill in "page[body_original]" with "Sippendi sipsi, lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."'
  Then 'I fill in "Ime kontaktne osebe" with "Lorem"'
  Then 'I fill in "Priimek kontaktne osebe" with "Diper"'
end