Feature: Users
  As an admin
  I want to manage system users
  So that I can distribute the work
  
  Background:
    Given I am logged in as an admin
    And the following user_kinds exist
    | name        | kind     |
    | Urednik     | editor   |
    | Oblikovalec | designer |
    | Lektor      | reviewer |
    
  Scenario: List and create users
    When I go to the users list page
    And I follow "Dodaj uporabnika"
    Then I select "Urednik" from "Vrsta uporabnika"
    And I fill in "Ime" with "Joze"
    And I fill in "Priimek" with "Krenker"
    And I fill in "E-mail" with "joze.krenker@gmail.com"
    And I fill in "Geslo" with "joze"
    And I press "Shrani"
    Then I should be on the show page for the user "Joze Krenker"
    And I should see "Joze Krenker"
    Then I go to the users list page
    And I should see "Joze"
    And I should see "Krenker"
    
  Scenario: Destroy user
    Given a user exists with name: "Simon", surname: "Talek"
    And I go to the show page for that user
    And I follow "Odstrani"
    Then I should be on the users list page
    And I should not see "Simon"
    And I should not see "Talek"
    
  Scenario: Assign privileges
    Given a book: "vinskagora" exists with title: "Vinska Gora"
    And a section: "piresica" exists with book: book "vinskagora"
    And a page: "rebernik" exists with title: "Pri Reberniku", section: section "piresica"
    And a user_kind: "editor" exists with name: "Urednik", kind: "editor"
    And a user: "simon" exists with kind: user_kind "editor"
    And I go to the show page for that user
    And I check "Vinska Gora"
    And I press "Shrani"
    Then the "Vinska Gora" checkbox should be checked
    And the "Pri Reberniku" checkbox should be checked