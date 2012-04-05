Feature: Page viewing and editing
  As an admin
  I want to be able to browse sections and see all pages and edit them
  So that I can build the books and MAKE MONEY
  
  Background:
    Given a book_kind: "mojkraj" exists with name: "Moj Kraj"
    And a page_kind: "domacija" exists with book_kind: book_kind "mojkraj"
    And a book: "vinskagora" exists with title: "Vinska Gora", kind: book_kind "mojkraj"
    And a book: "konovo" exists with title: "Konovo", kind: book_kind "mojkraj", published: false, password: "kokonovo"
    And a section: "piresica" exists with name: "Pirešica", book: book "vinskagora"
    And a section: "janskovoselo" exists with name: "Janškovo selo", book: book "vinskagora"
    And a section: "senbric" exists with name: "Šenbric", book: book "konovo"
    And a section: "cestax" exists with name: "Cesta X", book: book "konovo"
    And the following pages exist
    | title         | section                | street      | street_number | email              | email_published | published | kind                  |
    | Pri Reberniku | section "piresica"     | Pirešica    | 2             | info@rebernik.info | false           | true      | page_kind: "domacija" |
    | Pri Firerju   | section "piresica"     |             |               |                    |                 | false     | page_kind: "domacija" |
    | Pri Gajšeku   | section "janskovoselo" |             |               |                    |                 | true      | page_kind: "domacija" |
    | Pri Zdenki    | section "senbric"      |             |               | zdenka@senbric.si  | false           | false     | page_kind: "domacija" |
    | Pri Fritzlu   | section "senbric"      |             |               |                    |                 | true      | page_kind: "domacija" |
    | Pri Jozici    | section "cestax"       |             |               |                    |                 | true      | page_kind: "domacija" |
    And I am logged in as an admin
    
  Scenario: Show public page
    When I go to the sections list page for book "Vinska Gora"
    And I follow "Pirešica"
    Then I should be on the pages list page for section "Pirešica"
    And I should see "Pri Reberniku"
    And I should see "Pri Firerju"
    Then I follow "Odpri"
    And I should be on the show page for page "Pri Reberniku"
    And I should see "info@rebernik.info"
    And I should see "Pirešica 2"
    
  Scenario: Show page of an unpublished book
    When I go to the show page for page "Pri Fritzlu"
    Then I should not see "Ta knjiga je zaščitena."
    And I should be on the show page for page "Pri Fritzlu"

  Scenario: Edit page
    When I go to the show page for page "Pri Fritzlu"
    And I follow "Uredi stran"
    Then I should be on the edit page for page "Pri Fritzlu"
    And I fill in "Naslov" with "Pri Slovenskem Fritzlu"
    And I fill in "Ulica" with "Slovenska cesta"
    And I fill in "Ulična številka" with "56"
    And I press "Shrani"
    Then I should be on the show page for page "Pri Slovenskem Fritzlu"
    And I should see "Slovenska cesta 56"