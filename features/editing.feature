Feature: Editing Journal Entries
  Put an edit button on post views if I'm logged in, allow me to edit posts,
  allows me to use markdown syntax & renders it to html
  highlights code in python

  Scenario: Editing link appears while logged in
    Given There is an existing entry
    When I am logged in
    Then I see an edit link

  Scenario: Editing link hidden while logged out
    Given There is an existing entry
    When I am logged out
    Then I do not see an edit link

  Scenario: Editing link works
    Given There is an existing entry
    And I am logged in
    When I click the edit link
    Then I see an update form

  Scenario: Update form works
    Given There is an existing entry
    And I am logged in
    When I type "boogaboo" in the form and click update
    Then I see "boogaboo" on the main page


# Feature: Markdown renders on entries
  # Scenario: Writing markdown
  #   When I submit a post with the following:
  #     """
  #     A code snippet
  #     ==============
  #     ```
  #     for i in range(10):
  #         print i
  #     ```
  #     """
  #   Then I see the following:
  #     """
  #     <h1>A code snippet</h1>
  #     <p><code>python
  #     for i in range(10):
  #         print i
  #     </code></p>
  #     """

  # Scenario: Writing markdown with python code
  #   When I submit a post with the following:
  #     """
  #     A code snippet
  #     ==============
  #     ```
  #     print "Hello World"
  #     ```
  #     """
  #   Then I see the following:
  #     """
  #     <div class="highlight">
  #     <pre><span class="k">print</span> <span class="s">&quot;Hello World&quot;</span></pre>
  #     </div>
  #     """
