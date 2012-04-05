Feature: Page kinds
  As an admin
  I want to manage page kinds
  So that pages are easier to maintain
  
  Background:
    Given a book_kind: "mojkraj" exists with name: "Moj Kraj"
    And a book: "vinskagora" exists with title: "Vinska Gora", kind: book_kind "mojkraj"
    And a section: "prelska" exists with name: "Prelska", book: book "vinskagora"
    And the following page_kinds exist
    | name     | page_fields | book_kind            |
    | Domačija |             | book_kind: "mojkraj" |
    | Društvo  |             | book_kind: "mojkraj" |
    
  Scenario: List page kinds
    When I am logged in as an admin 
    And I go to the show page for book kind "Moj Kraj"
    Then I should see "Domačija"
    And I should see "Društvo"
    
  Scenario: Create new page kind and try to use it
    When I am logged in as an admin
    And I go to the show page for book kind "Moj Kraj"
    And I follow "Dodaj tip strani"
    Then I fill in "Naziv tipa strani" with "Znamenitost"
    And I check "Naslov (ulica in poštna št.)"
    And I check "Mobilnik"
    And I fill in "Naslov" with "Naziv znamenitosti"
    And I fill in "Besedilo" with "Opis znamenitosti"
    Then I press "Shrani"
    And I should be on the show page for book kind "Moj Kraj"
    Then I go to the sections list page for book "Vinska Gora"
    And I follow "Prelska"
    And I follow "Dodaj: Znamenitost"
    And I fill in "Naziv znamenitosti" with "Slamnata hiša"
    And I fill in "Opis znamenitosti" with "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    And I press "Shrani"
    Then I should be on the show page for page "Slamnata hiša"
    And I should see "Lorem ipsum dolor sit amet"
    