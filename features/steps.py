from __future__ import unicode_literals

from lettuce import step
from lettuce import world

from journal import get_database_connection
from journal import app

# from flask import session


@step('There is an existing entry')
def add_entry(step):

    from journal import write_entry
    expected = ('Test Title', 'Test Text')

    with app.test_request_context('/'):
        write_entry(*expected)
        # manually commit transaction here to avoid rollback due to
        # handled exceptions
        get_database_connection().commit()

    world.expected = expected


@step('I am logged in')
def login(step):
    login_data = {
        'username': 'admin', 'password': 'admin'
    }
    client = app.test_client()
    response = client.post(
        '/login', data=login_data, follow_redirects=True
    )
    world.page = response.data


@step('I am logged out')
def logout(step):
    client = app.test_client()
    response = client.get('/')
    world.page = response.data


@step('I see a[n]? ([a-z ]+) link')
def see_link(step, text):
    assert (text + "</a>") in world.page


@step('I do not see a[n]? ([a-z ]+) link')
def no_link(step, text):
    assert (text + "</a>") not in world.page


@step('I click the edit link')
def click_edit(step):
    login_data = {
        'username': 'admin', 'password': 'admin'
    }
    with app.test_client() as c:
        c.post('/login', data=login_data)  # Logically this should be in the
        response = c.get('/edit/1')        # login step, but it doesn't persist
        world.page = response.data


@step('I see an update form')
def see_update_form(step):
    assert '<input type="submit" value="Update" name="Update"/>' in \
        world.page


@step('When I type "([^"]*)" in the form and click update')
def use_update_form(step, string1):
    entry_data = {
        'title': string1,
        'text': string1
    }
    world.page = app.test_client().post(
        '/update/1', data=entry_data, follow_redirects=True
    ).data


@step('Then I see "([^"]*)" on the main page')
def see_updated_entry(step, string1):
    assert string1 in world.page


@step('I submit a post with the following:')
def write_post(step):
    from journal import write_entry
    expected = (u'Test Title', step.multiline)

    with app.test_request_context('/'):
        write_entry(*expected)
        # manually commit transaction here to avoid rollback due to
        # handled exceptions
        get_database_connection().commit()


@step('I see the following:')
def post_contains(step):
    client = app.test_client()
    response = client.get('/')
    assert step.multiline in response.data
