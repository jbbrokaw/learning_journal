Feature: Markdown renders on entries
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
      <p><code>for i in range(10):
      print i</code></p>
      """

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
