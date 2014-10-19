Feature: Editing with Markdown
  Put an edit button on post views if I'm logged in, allow me to edit posts,
  allows me to use markdown syntax & renders it to html
  highlights code in python

  Scenario: Editing while logged in
    Given There is an existing entry
    When I log in
    Then I see an edit link

  Scenario: Writing markdown
    When I submit a post with the following:
      """
      A code snippet
      ==============
      ```
      for i in range(10):
          print i
      ```
      """
    Then I see the following:
      """
      <h1>A code snippet</h1>
      <p><code>python
      for i in range(10):
          print i
      </code></p>
      """

  Scenario: Writing markdown with python code
    When I submit a post with the following:
      """
      A code snippet
      ==============
      ```
      print "Hello World"
      ```
      """
    Then I see the following:
      """
      <div class="highlight">
      <pre><span class="k">print</span> <span class="s">&quot;Hello World&quot;</span></pre>
      </div>
      """
