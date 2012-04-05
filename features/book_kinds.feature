Feature: Book kinds
  As an admin
  I want to manage book kinds
  So that the system can base books on them
  
  Background:
    Given the following book_kinds exist
    | name          |
    | Moj kraj      |
    | Moje podjetje |
    | Moja banka    |
    
  Scenario: List book kinds
    When I am logged in as an admin 
    And I go to the book kinds list page
    Then I should see "Moj kraj"
    And I should see "Moje podjetje"
    And I should see "Moja banka"
    
  Scenario: Restrict list to guests
    When I go to the book kinds list page
    Then I should be on the login page
    And I should see "Prosimo prijavite se s svojim administratorskim računom."
    
  Scenario: Delete book kind
    When I am logged in as an admin 
    And I go to the show page for book kind "Moj kraj"
    And I follow "Odstrani"
    Then I should be on the book kinds list page
    And I should not see "Moj kraj"
    
  Scenario: Edit book
    When I am logged in as an admin 
    And I go to the edit page for book kind "Moj kraj"
    And I fill in "Naziv tipa" with "Moje podezelje"
    And I press "Shrani"
    Then I should be on the show page for book kind "Moje podezelje"
    And I should see "Moje podezelje"
