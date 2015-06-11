#!/bin/bash
# Takes the name of the project as the first argument

# Make folder structure
if [ -d "$1" ]
then
  echo "Directory $1 exists"
else
  echo "Creating app structure..."

  mkdir "$1"
  mkdir "$1/app"
  mkdir "$1/app/templates"
  mkdir "$1/app/static"

  # Make files
  touch "$1/run.py"
  touch "$1/config.py"
  touch "$1/app/__init__.py"
  touch "$1/app/forms.py"
  touch "$1/app/models.py"
  touch "$1/app/views.py"

  # Populate file contents
  echo "from app import app
app.run(host='0.0.0.0', port=8080, debug=True)
" >> $1/run.py

  echo "# Statement for enabling the development environment
DEBUG = True

# Define the application directory
import os
BASE_DIR = os.path.abspath(os.path.dirname(__file__))

# Define the database - we are working with
# SQLite for this example
SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(BASE_DIR, 'app.db')
DATABASE_CONNECT_OPTIONS = {}

# Application threads. A common general assumption is
# using 2 per available processor cores - to handle
# incoming requests using one and performing background
# operations using the other.
THREADS_PER_PAGE = 2

# Enable protection agains *Cross-site Request Forgery (CSRF)*
CSRF_ENABLED = True

# Use a secure, unique and absolutely secret key for
# signing the data.
CSRF_SESSION_KEY = "secret"

# Secret key for signing cookies
SECRET_KEY = \"secret\"
" >> $1/config.py

  echo "from flask import Flask, render_template
from flask.ext.sqlalchemy import SQLAlchemy

# Define the WSGI application object
app = Flask(__name__)

# Configurations
app.config.from_object('config')

# Define the database object which is imported
# by modules and controllers
db = SQLAlchemy(app)


# Put views import after app creation to avoid circular import
from app import views, models
" >> $1/app/__init__.py

fi
