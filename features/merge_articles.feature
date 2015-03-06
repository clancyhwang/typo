Feature: Merge_Articles
  As an admin
  In order to merge different articles
  I want to merge blog entries using article ID

Background:
  Given the blog is set up
  Given the following users exist:
    | profile_id | login  | name  | password | email           | state  |
    | 2          | tarry  | Tarry | 1234567  | 123@example.com | active |
    | 3          | kevin  | Kevin | 1234567  | 456@example.com | active |

  Given the following articles exist:
    | id | title| author | user_id | body        | allow_comments | published | published_at        | state     | type    |
    | 3  | TTL1 | tarry  | 2       | TTLContent1 | true           | true      | 2013-23-11 21:30:00 | published | Article |
    | 4  | TTL2 | kevin  | 3       | TTLContent2 | true           | true      | 2013-24-11 22:00:00 | published | Article |

  Given the following comments exist:
    | id | type    | author | body     | article_id | user_id | created_at          |
    | 1  | Comment | tarry  | Comment1 | 3          | 2       | 2013-23-11 21:31:00 |
    | 2  | Comment | tarry  | Comment2 | 4          | 2       | 2013-24-11 22:01:00 |

Scenario: non-admin cannot merge articles
  Given I am logged in as "tarry" with passphrase "1234567"
  And I am on the article editing page with id 3
  Then I should not see "Merge Articles"

Scenario: admin can merge articles
  Given I am logged in as "admin" with passphrase "aaaaaaaa"
  And I am on the article editing page with id 3
  Then I should see "Merge Articles"
  When I fill in "merge_with" with "4"
  And I press "Merge"
  Then I should be on the admin content page
  #And I should see "Articles successfully merged!"

Scenario: The merged articles should contain the text of both previous articles
  Given the articles with id "3" and "4" were successfully merged
  And I am on the home page
  Then I should see "TTL1"
  When I follow "TTL1"
  Then I should see "TTLContent1"
  And I should see "TTLContent2"

Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article
  Given the articles with id "3" and "4" were successfully merged
  And I am on the home page
  Then I should see "TTL1"
  When I follow "TTL1"
  Then I should see "Comment1"
  And I should see "Comment2"

Scenario: When articles are merged, the merged article should contain the text of both previous articles
  Given the articles with id "3" and "4" were successfully merged
  And I am on the home page
  Then I should see "TTL1"
  When I follow "TTL1"
  Then I should see "TTLContent1"
  And I should see "TTLContent2"

Scenario: When articles are merged, the merged article should have one author (either one of the authors of the original article)
  Given the articles with id "3" and "4" were successfully merged
  Then "Tarry" should be author of 1 articles
  And "Kevin" should be author of 0 articles

Scenario: The title of the new article should be the title from either one of the merged articles
  Given the articles with id "3" and "4" were successfully merged
    And I am on the home page
    Then I should see "TTL1"
    And I should not see "TTL2"
