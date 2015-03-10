Feature: Edit categories
         As an blog admin
         In order to keep blog neat and organized
         I want to be able to create categories, and add/remove articles to them
  Background:
    Given the blog is set up
    Given the following users exist:
      | profile_id | login  | name  | password | email             | state  |
      | 1          | admin  | Admin | aaaaaaaa | admin@example.com | active |
      | 2          | tarry  | Tarry | 1234567  | 123@example.com   | active |
      | 3          | kevin  | Kevin | 1234567  | 456@example.com   | active |

    And the following categories exist:
      |  name  | permalink | position |
      | Ctg2   |   cat2    |     2    |
      | Ctg3   |   cat3    |     3    |

  Scenario: View categories as Admin
    Given I am logged in as "admin" with passphrase "aaaaaaaa"
    When I follow "Categories"
    Then I should see "Ctg2"
    And I should see "Ctg3"
