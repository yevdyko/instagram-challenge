# Pixagram

[![Build Status](https://travis-ci.org/yevdyko/pixagram.svg?branch=master)](https://travis-ci.org/yevdyko/pixagram)  [![Coverage Status](https://coveralls.io/repos/github/yevdyko/pixagram/badge.svg?branch=master)](https://coveralls.io/github/yevdyko/pixagram?branch=master)  [![Code Climate](https://codeclimate.com/github/yevdyko/pixagram/badges/gpa.svg)](https://codeclimate.com/github/yevdyko/pixagram)

An application that allows users to post pictures to a public stream. The basic requirements were that users should be able to sign up for a new account, log in or out, post new pictures, write comments on pictures, like a picture and add filters.

## Technologies used

- Ruby on Rails
- PostgreSQL database
- Tested with RSpec and Capybara

## User Stories

```
As a User
So that I can post pictures on Pixagram as me
I want to register for my account

As a User
So that I can post pictures on Pixagram as me
I want to log in and log out of my account

As a User
So that I can let people know what I am doing
I want to post pictures on Pixagram

As a User
So that I can rectify what I originally post
I want to edit/delete my posts

As a User
So that I can see what others are posting
I want to see all pictures in reverse chronological order

As a User
So that I can appreciate the context of a picture
I want to see the time at which it was posted

As a User
So that I can let people know my thoughts
I want to leave a comment on picture

As a User
So that I can rectify what I originally write
I want to edit/delete my comments

As a User
So that I can register my appreciation of the picture
I want to like other users' pictures

As a User
So that I can't tally up the likes of a picture
I want to like pictures once
```

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

## Screenshots
