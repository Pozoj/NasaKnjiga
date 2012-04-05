Feature: Page editor
  As an editor
  I want to edit all pages that I have permission to
  So that the books get bigger and better
  
  Background:
    Given a book_kind: "mojkraj" exists with name: "Moj Kraj"
    And a page_kind: "domacija" exists with name: "Domačija", book_kind: book_kind "mojkraj"
    And a book: "vinskagora" exists with title: "Vinska Gora", kind: book_kind "mojkraj"
    And a book: "konovo" exists with title: "Konovo", kind: book_kind "mojkraj"
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


  Scenario: Try to create page in permitted book
    Given I am logged in as an editor for the book "Vinska Gora"
    When I go to the pages list page for section "Pirešica"
    And I follow "Dodaj: Domačija"
    And I fill in the page fields
    And I press "Shrani stran"
    Then I go to the pages list page for section "Pirešica"
    And I should see "Lorem Ipsum"

  Scenario: Try to edit permitted book page
    Given I am logged in as an editor for the book "Vinska Gora"
    When I go to the book list page
    And I follow "Vinska Gora"
    And I follow "Pirešica"
    And I should see "Pri Firerju"
    And I follow "Odpri"
    And I follow "Uredi stran"
    Then I should see "Pri Reberniku"
    And I fill in "page[title]" with "Pri Rabarniku"
    And I press "Shrani stran"
    And I should see "Pri Rabarniku"
    
  Scenario: Try to edit not permitted book
    Given I am logged in as an editor for the book "Vinska Gora"
    When I go to the book list page
    And I follow "Konovo"
    And I follow "Cesta X"
    Then I should see "Pri Jozici"
    Then I follow "Odpri"
    And I should see "Pri Jozici"
    And I should not see "Uredi"

  Scenario: Try to go directly and edit a page inside a non permitted book
    Given I am logged in as an editor for the book "Vinska Gora"
    When I go to the edit page for page "Pri Jozici"
    Then I should be on the login page
    And I should see "Prosimo prijavite se s svojim uredniškim ali lektorskim računom."
    
  Scenario: Edit a permitted page
    Given I am logged in as an editor for the page "Pri Zdenki"
    When I go to the book list page
    And I follow "Konovo"
    And I follow "Šenbric"
    And I follow "Uredi"
    And I should see "Pri Zdenki"
    And I fill in "page[title]" with "Pri Rabarniku"
    And I press "Shrani stran"
    And I should see "Pri Rabarniku"
    
  Scenario: Destroy page
    Given a book: "knjiha" exists with title: "Knjiha"
    And a section: "piresica" exists with name: "Piresica", book: book "knjiha"
    And a page exists with title: "Sztran", section: section "piresica"
    And I am logged in as an editor for the book "Knjiha"
    When I go to the show page for page "Sztran"
    And I follow "Odstrani stran"
    Then I should be on the pages list page for section "Piresica"
    And I should not see "Sztran"