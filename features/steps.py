from lettuce import step
from lettuce import world

from journal import get_database_connection
from journal import app


@step('There is an existing entry')
def add_entry(step):

    from journal import write_entry
    expected = (u'Test Title', u'Test Text')

    with app.test_request_context('/'):
        write_entry(*expected)
        # manually commit transaction here to avoid rollback due to
        # handled exceptions
        get_database_connection().commit()

    world.expected = expected


@step('I log in')
def login(step):
    login_data = {
        'username': 'admin', 'password': 'admin'
    }
    client = app.test_client()
    response = client.post(
        '/login', data=login_data, follow_redirects=True
    )
    world.page = response.data


@step('I see a[n]? ([a-z ]+) link')
def see_link(step, text):
    assert (text + "</a>") in world.page


@step('I see a[n]? ([a-z]+) tag')
def see_tag(step, tag):
    assert ("<" + tag + ">") in world.page
