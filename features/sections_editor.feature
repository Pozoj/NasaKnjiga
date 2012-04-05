Feature: Section editor
  As an editor
  I want to edit the sections of the books that I am allowed to
  So that the books get bigger and better
  
  Background:
    Given a book_kind: "mojkraj" exists with name: "Moj Kraj"
    And a page_kind: "domacija" exists with name: "Domačija", book_kind: book_kind "mojkraj"
    And a book: "vinskagora" exists with title: "Vinska Gora", kind: book_kind "mojkraj"

  Scenario: Try to create section in permitted book
    Given I am logged in as an editor for the book "Vinska Gora"
    When I go to the sections list page for book "Vinska Gora"
    And I follow "Dodaj novo sekcijo"
    And I fill in "Naziv sekcije" with "Simonov zaselek"
    And I press "Shrani"
    Then I should be on the sections list page for book "Vinska Gora"
    And I should see "Simonov zaselek"