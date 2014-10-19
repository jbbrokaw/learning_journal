Feature: Markdown renders on entries
  Scenario: Writing markdown
    When I submit a post with the following:
      """
      A title
      ==============
      1. Thing 1
      2. Thing 2
      """
    Then I see the following:
      """<h1>A title</h1>
      <ol>
      <li>Thing 1</li>
      <li>Thing 2</li>
      </ol>
      """

  Scenario: Writing markdown with python code
    When I submit a post with the following:
      """
      A code snippet
      ==============
      ```python
      print 'Hello World'
      ```
      """
    Then I see the following:
      """
      <div class="codehilite"><pre><span class="k">print</span> <span class="s">&#39;Hello World&#39;</span>
      </pre></div>
      """
