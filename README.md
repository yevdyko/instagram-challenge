# Pixagram

[![Build Status](https://travis-ci.org/yevdyko/pixagram.svg?branch=master)](https://travis-ci.org/yevdyko/pixagram)  [![Coverage Status](https://coveralls.io/repos/github/yevdyko/pixagram/badge.svg?branch=master)](https://coveralls.io/github/yevdyko/pixagram?branch=master)  [![Code Climate](https://codeclimate.com/github/yevdyko/pixagram/badges/gpa.svg)](https://codeclimate.com/github/yevdyko/pixagram)

A social networking application that allows users to share photos in a public stream. 

The basic requirements were that users should be able to register with email, log in and out, add photos, see a profile of each user and follow other users. Besides that users can browse through the latest photos of people whom they follow with updates as people post new photos. Like photos by pressing the like button. Or, engage in a conversation around a photo with inline commenting. In addition, users get real-time notifications when someone followes them, likes or comments their picture.

## Technologies used

- PostgreSQL database
- Ruby 2.3.1
- Ruby on Rails 5.0.0.1
- JavaScript
- jQuery
- Bootstrap
- HAML/SCSS
- Tested with RSpec and Capybara

## Development

Development process is based on requirements of user stories and using a Trello board with features for project management.

[User Stories](https://docs.google.com/spreadsheets/d/1bOTAvQBNr7DxlnJNqAXoQ04aVVGb42aQCy0ad_cK2pc/edit?usp=sharing) | [Trello Board](https://trello.com/b/SfmTPlNb)

## Setup

Clone the repository:

    $ git clone git@github.com:yevdyko/pixagram.git

Change into the directory:

    $ cd pixagram

If you don't have bundle already, run the command:

    $ gem install bundle

Install the local gems while suppressing the installation of production gems using the `--without production` option:

    $ bundle install --without production

Create a development database:

    $ createdb pixagram_development

Run the migrations to setup the database:

    $ rake db:migrate

Start the server:

    $ rails server

Go to your browser and open [http://localhost:3000](http://localhost:3000)

## Testing

Create a test database:

    $ createdb pixagram_test

Setup the test database using the rake task:

    $ rake db:migrate RACK_ENV=test

To run the tests:

    $ rspec
