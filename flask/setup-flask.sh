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
  mkdir "$1/app/static/css"
  mkdir "$1/app/static/js"

  # Make files
  touch "$1/run.py"
  touch "$1/config.py"
  touch "$1/app/__init__.py"
  touch "$1/app/forms.py"
  touch "$1/app/models.py"
  touch "$1/app/views.py"
  touch "$1/app/templates/index.html"

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
CSRF_SESSION_KEY = \"secret\"

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

  <title>$1</title>

  <!-- Bootstrap core CSS -->
  <link href=\"../static/css/bootstrap.min.css\" rel=\"stylesheet\">

  <!-- Custom styles for this template -->
  <link href=\"jumbotron-narrow.css\" rel=\"stylesheet\">
</head>

<body>

  <div class=\"container\">
    <div class=\"header clearfix\">
      <nav>
        <ul class=\"nav nav-pills pull-right\">
          <li role=\"presentation\" class=\"active\"><a href=\"#\">Home</a></li>
          <li role=\"presentation\"><a href=\"#\">About</a></li>
          <li role=\"presentation\"><a href=\"#\">Contact</a></li>
        </ul>
      </nav>
      <h3 class=\"text-muted\">$1</h3>
    </div>

    <div class=\"jumbotron\">
      <h1>Jumbotron heading</h1>
      <p class=\"lead\">Cras justo odio, dapibus ac facilisis in, egestas eget quam. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
      <p>
        <a class=\"btn btn-lg btn-success\" href=\"#\" role=\"button\">Sign up today</a>
      </p>
    </div>

    <div class=\"row marketing\">
      <div class=\"col-lg-6\">
        <h4>Subheading</h4>
        <p>Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>

        <h4>Subheading</h4>
        <p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>

        <h4>Subheading</h4>
        <p>Maecenas sed diam eget risus varius blandit sit amet non magna.</p>
      </div>

      <div class=\"col-lg-6\">
        <h4>Subheading</h4>
        <p>Donec id elit non mi porta gravida at eget metus. Maecenas faucibus mollis interdum.</p>

        <h4>Subheading</h4>
        <p>Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cras mattis consectetur purus sit amet fermentum.</p>

        <h4>Subheading</h4>
        <p>Maecenas sed diam eget risus varius blandit sit amet non magna.</p>
      </div>
    </div>

    <footer class=\"footer\">
      <p>© Company 2014</p>
    </footer>

  </div> <!-- /container -->


  <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
  <script src=\"../../assets/js/ie10-viewport-bug-workaround.js\"></script>

</body>

</html>
" >> $1/app/templates/index.html

fi
