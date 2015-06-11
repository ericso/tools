#!/bin/bash
# Takes the name of the project as the first argument

# Make folder structure
if [ -d "$1" ]
then
  echo "Directory $1 exists"
else
  echo "Creating app structure..."

  mkdir "$1"
  mkdir "$1/client"
  mkdir "$1/server"
  mkdir "$1/server/app"
  mkdir "$1/server/app/templates"
  mkdir "$1/server/app/static"
  mkdir "$1/server/app/static/css"
  mkdir "$1/server/app/static/js"

  # Make files
  touch "$1/server/run.py"
  touch "$1/server/config.py"
  touch "$1/server/app/__init__.py"
  touch "$1/server/app/forms.py"
  touch "$1/server/app/models.py"
  touch "$1/server/app/views.py"
  touch "$1/server/app/templates/index.html"

  # Populate file contents

  # server/run.py
  echo "from app import app
app.run(host='0.0.0.0', port=8080, debug=True)
" >> $1/server/run.py

  # server/config.py
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
CSRF_SESSION_KEY = \"secret\"

# Secret key for signing cookies
SECRET_KEY = \"secret\"
" >> $1/server/config.py

  # server/app/__init__.py
  echo "from flask import Flask
from flask.ext import restful
from flask.ext.restful import reqparse, Api
from flask.ext.sqlalchemy import SQLAlchemy

# Define the WSGI application object
app = Flask(__name__)

# Configurations
app.config.from_object('config')

# Define the database object which is imported
# by modules and controllers
db = SQLAlchemy(app)

# Flask-Restful
api = restful.Api(app)

# Put views import after app creation to avoid circular import
from app import views
" >> $1/server/app/__init__.py

  # server/app/views.py
  echo "from flask import render_template
from app import app

@app.route('/')
@app.route('/index')
def index():
  return render_template('index.html')
" >> $1/server/app/views.py

  # server/app/templates/index.html
  echo "<!doctype html>
<html>
<head>
  <meta charset=\"utf-8\">
  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
  <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
  <meta name=\"description\" content=\"\">
  <meta name=\"author\" content=\"\">
  <link rel=\"icon\" href=\"../../favicon.ico\">

  <title>Scrying-Me</title>

  <!-- Bootstrap core CSS -->
  <link href=\"../static/css/bootstrap.min.css\" rel=\"stylesheet\">

</head>

<body>
  <script src=\"../../client/js/app.js\"></script>
</body>

</html>
" >> $1/server/app/templates/index.html

fi
