Feature: Show Project
  In order to know all the repositories of the given project and its contents
  As a regular user
  I should be able to see each of them

@kalibro_restart
Scenario: Should not show the create repository link to user that doesn't own the project
  Given I am a regular user
  And I have a sample project
  And I have a sample configuration with native metrics
  And I have a sample repository within the sample project
  When I am at the Sample Project page
  Then I should not see New Repository
  And I should not see Destroy project
  And I should not see Edit

@kalibro_restart
Scenario: Should show the create repository link the project owner
  Given I am a regular user
  And I am signed in
  And I own a sample project
  When I am at the Sample Project page
  Then I should see "New Repository"


@kalibro_restart
Scenario: Considering the project has no repositories
  Given I have a sample project
  When I am at the Sample Project page
  Then I should see "There are no repositories yet!"

@kalibro_restart
Scenario: Considering the project has repositories
  Given I have a sample project
  And I have a sample configuration with native metrics
  And I have a sample repository within the sample project
  When I am at the Sample Project page
  Then I should not see There are no repositories yet!

@kalibro_restart
Scenario: Checking project contents
  Given I have a sample project
  When I am at the Sample Project page
  Then the sample project should be there
