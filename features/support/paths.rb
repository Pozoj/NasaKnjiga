module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
          
    # Books
    when /the book list page/
      books_path
    when /the edit page for book "(.+)"/
      edit_book_path(Book.find_by_title($1))
    when /the show page for book "(.+)"/
      book_path(Book.find_by_title($1))
    
    # Pages
    when /the pages list page for book "(.+)"/
      book_pages_path(Book.find_by_title($1))
    when /the show page for page "(.+)"/
      page = Page.find_by_title($1)
      section_page_path(page.section, page, :subdomain => page.book.subdomain)
    when /the edit page for page "(.+)"/
      page = Page.find_by_title($1)
      edit_section_page_path(page.section, page, :subdomain => page.book.subdomain)
    when /the sections list page for book "(.+)"/
      root_path(:subdomain => Book.find_by_title($1).subdomain)
    when /the pages list page for section "(.+)"/
      section = Section.find_by_name($1)
      section_pages_path(section, :subdomain => section.book.subdomain)
      
    # Sections
    when /the sections list page for book "(.+)"/
      sections_path :subdomain => Book.find_by_title($1).subdomain
      
    # Book kinds
    when /the book kinds list page/
      book_kinds_path(:subdomain => false)
    when /the edit page for book kind "(.+)"/
      edit_book_kind_path(BookKind.find_by_name($1))
    when /the show page for book kind "(.+)"/
      book_kind_path(BookKind.find_by_name($1))
    
    # Users
    when /the users list page/
      users_path(:subdomain => false)
    when /the show page for the user "(.+)"/
      name, surname = $1.split(" ")
      user = User.find_by_name_and_surname(name, surname)
      user_path user
    
    # Sessions
    when /the login page/
      new_session_path
    
    #
    #  
    # Pickle generics
    when /the show page for (that .+)/
      polymorphic_path model($1)
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
