Feature: Page review
  As a reviewer
  I want to be able to browse sections and see all pages of allowed books
  So that I can review and correct copy
  
  Background:
    Given a book_kind: "mojkraj" exists with name: "Moj Kraj"
    And a book: "vinskagora" exists with title: "Vinska Gora", kind: book_kind "mojkraj"
    And a book: "konovo" exists with title: "Konovo", kind: book_kind "mojkraj", published: false, password: "kokonovo"
    And a section: "piresica" exists with name: "Pirešica", book: book "vinskagora"
    And a section: "janskovoselo" exists with name: "Janškovo selo", book: book "vinskagora"
    And a section: "senbric" exists with name: "Šenbric", book: book "konovo"
    And a section: "cestax" exists with name: "Cesta X", book: book "konovo"
    And the following pages exist
    | title         | section                | body                  | email              | email_published | published |
    | Pri Reberniku | section "piresica"     | Simon Talek je prisel | info@rebernik.info | true            | true      |
    | Pri Firerju   | section "piresica"     | a                     |                    |                 | false     |
    | Pri Gajšeku   | section "janskovoselo" | b                     |                    |                 | true      |
    | Pri Zdenki    | section "senbric"      | c                     | zdenka@senbric.si  | false           | false     |
    | Pri Fritzlu   | section "senbric"      | d                     |                    |                 | true      |
    | Pri Jozici    | section "cestax"       | e                     |                    |                 | true      |
    Given I am logged in as a reviewer for the book "Vinska Gora"


  Scenario: Review page
    When I go to the book list page
    And I follow "Vinska Gora"
    Then I should be on the sections list page for book "Vinska Gora"
    And I should see "Pirešica"
    Then I follow "Pirešica"
    And I should see "Pri Reberniku"
    And I should see "Pri Firerju"
    Then I follow "Odpri"
    And I should see "Pri Reberniku"
    And I should not see "Uredi stran"
    And I should not see "Odstrani stran"
    And I follow "Lektoriraj stran"
    Then I should be on the edit page for page "Pri Reberniku"
    And I should not see "Naslov"
    And I should not see "Telefon"
    And I should see "Besedilo original"
    Then I fill in "Besedilo lektorirano" with "Lorem ipsam"
    And I press "Shrani"
    Then I should be on the show page for page "Pri Reberniku"
    And I should see "Lorem ipsam"
    And I should not see "Simon Talek je prisel"