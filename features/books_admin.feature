Feature: Book manipulation
  As an admin
  I want to be able to add a new book
  So that others can add pages to it
  
  Background:
    Given a book_kind: "mojkraj" exists with name: "Moj Kraj"
    And a book: "vinskagora" exists with title: "Vinska Gora", kind: book_kind "mojkraj"
    And the following books exist
    | title        | kind                |
    | Konovo       | book_kind "mojkraj" |
    | Goriška brda | book_kind "mojkraj" |
    | Šalek        | book_kind "mojkraj" |
    | Florjan      | book_kind "mojkraj" |
    And a section: "section" exists with name: "Zaselek", book: book "vinskagora"
    And a page exists with title: "Pri Reberniku", section: section "section"
    And I am logged in as an admin
    
  Scenario: Hide book
    When I go to the edit page for book "Vinska Gora"
    And I uncheck "Knjiga vidna?"
    And I press "Shrani"
    Then I go to the book list page
    And I should see "Vinska Gora"
    And I should see "Konovo"
    And I should see "Florjan"
    Then I logout
    And I go to the book list page
    And I should not see "Vinska Gora"
    
  Scenario: Show book
    When I go to the book list page
    And I follow "Vinska Gora"
    Then I should be on the show page for book "Vinska Gora"
    And I should see "eno stran"
    And I should see "eno sekcijo"
    Then I follow "Odpri knjigo"
    And I should see "Zaselek"
    
  Scenario: Delete book
    When I go to the show page for book "Florjan"
    And I follow "Odstrani"
    Then I should be on the book list page
    And I should not see "Florjan"
    
  Scenario: Edit book
    When I go to the edit page for book "Konovo"
    And I fill in "Naslov" with "Jezero"
    And I press "Shrani"
    Then I should be on the show page for book "Jezero"
    And I should see "Jezero"
    