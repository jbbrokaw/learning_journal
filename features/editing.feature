Feature: Editing
    Put an edit button on post views if I'm logged in, allow me to edit posts

    Scenario: Editing available
        Given There is an existing entry
        When I log in
        Then I see a log out link
        And I see an edit link
