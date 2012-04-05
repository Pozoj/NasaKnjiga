Feature: Page viewing
  As a guest
  I want to be able to browse sections and see public pages or enter a password to see pages of unpublished books
  So that I can enjoy the stuff on them
  
  Background:
    Given a book_kind: "mojkraj" exists with name: "Moj Kraj"
    And a book: "vinskagora" exists with title: "Vinska Gora", kind: book_kind "mojkraj"
    And a book: "konovo" exists with title: "Konovo", kind: book_kind "mojkraj", published: false, password: "kokonovo"
    And a section: "piresica" exists with name: "Pirešica", book: book "vinskagora"
    And a section: "janskovoselo" exists with name: "Janškovo selo", book: book "vinskagora"
    And a section: "senbric" exists with name: "Šenbric", book: book "konovo"
    And a section: "cestax" exists with name: "Cesta X", book: book "konovo"
    And the following pages exist
    | title         | section                | email              | email_published | published |
    | Pri Reberniku | section "piresica"     | info@rebernik.info | true            | true      |
    | Pri Firerju   | section "piresica"     |                    |                 | false     |
    | Pri Gajšeku   | section "janskovoselo" |                    |                 | true      |
    | Pri Zdenki    | section "senbric"      | zdenka@senbric.si  | false           | false     |
    | Pri Fritzlu   | section "senbric"      |                    |                 | true      |
    | Pri Jozici    | section "cestax"       |                    |                 | true      |

                                                       
  Scenario: List all public pages
    When I go to the book list page                    
    And I follow "Vinska Gora"
    Then I should be on the sections list page for book "Vinska Gora"
    And I should see "Pirešica"
    And I should see "Janškovo selo"
    
  Scenario: Show public page
    When I go to the sections list page for book "Vinska Gora"
    And I follow "Pirešica"
    Then I should be on the pages list page for section "Pirešica"
    And I should see "Pri Reberniku"
    And I should not see "Pri Firerju"
    Then I follow "Pri Reberniku"
    And I should be on the show page for page "Pri Reberniku"
    And I should see "info@rebernik.info"
    
  Scenario: Show page of an unpublished book
    When I go to the show page for page "Pri Fritzlu"
    Then I should see "Ta knjiga je zaščitena."
    And I fill in "Geslo za dostop" with "kokonovo"
    And I press "Naprej"
    Then I should be on the show page for page "Pri Fritzlu"
    And I should see "Dostop do knjige je dovoljen."
    
  Scenario: Order book based on page
    