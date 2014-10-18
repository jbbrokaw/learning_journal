from __future__ import unicode_literals
from contextlib import closing
from journal import app
from journal import connect_db
from journal import init_db
from lettuce import before
from lettuce import after

TEST_DSN = 'dbname=test_learning_journal user=jbbrokaw'
SUBMIT_BTN = '<input type="submit" value="Share" name="Share"/>'


@before.all
def configure_app_and_db():
    """configure our app for use in testing"""
    app.config['DATABASE'] = TEST_DSN
    app.config['TESTING'] = True
    """initialize the entries table and drop it when finished"""
    init_db()


@after.all
def clear_db(results):
    with closing(connect_db()) as db:
        db.cursor().execute("DROP TABLE entries")
        db.commit()
