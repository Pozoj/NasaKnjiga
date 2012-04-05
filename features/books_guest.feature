Feature: Book viewing
  As a guest
  I want to be able to see public books or enter a password to see hidden books
  So that I can enjoy all their pages
  
  Background:
    Given a book_kind: "mojkraj" exists with name: "Moj Kraj"
    And the following books exist
    | title        | kind                | published | password |
    | Vinska Gora  | book_kind "mojkraj" | true      |          |
    | Konovo       | book_kind "mojkraj" | false     | kokonovo |
    | Goriška brda | book_kind "mojkraj" | true      |          |
    | Šalek        | book_kind "mojkraj" | true      |          |
    | Florjan      | book_kind "mojkraj" | false     | folorjan |
    
  Scenario: List all books
    When I go to the book list page
    Then I should see "Vinska Gora"
    And I should not see "Konovo"
    And I should see "Šalek"
    And I should not see "Florjan"
    
  Scenario: Show a book
    When I go to the book list page
    And I follow "Vinska Gora"
    Then I should be on the sections list page for book "Vinska Gora"
    And I should see "Vinska Gora"
  
  Scenario: Show a protected book
    When I go to the sections list page for book "Konovo"
    Then I should see "Ta knjiga je zaščitena."
    Then I fill in "Geslo za dostop" with "kokonovo"
    And I press "Naprej"
    Then I should be on the sections list page for book "Konovo"
    And I should see "Konovo"
    
  Scenario: Do not show protected book if wrong password
    When I go to the sections list page for book "Konovo"
    Then I should see "Ta knjiga je zaščitena."
    Then I fill in "Geslo za dostop" with "kokonovosds"
    And I press "Naprej"
    Then I should see "Geslo za dostop do knjige ni pravilno!"
    And I should see "Dostop do knjige Konovo"