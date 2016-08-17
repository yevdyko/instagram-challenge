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
So that I can rectify what I originally comment
I want to delete my comments

As a User
So that I can protect comments from deleting by another user
I want to delete comments that only belong to me

As a User
So that I can add a 'Like' to the post
I want to click a little heart icon under the image

As a User
So that once I've liked a post
I want to see my username added to the post's list of likers

As a User
So that I can revoke my decision
I want to unlike a post by clicking the button again

As a User
So that once I've liked a post
I want to see the heart icon turn solid upon clicking it

As a User
So that a post has more than or equal to 4 likes
I want to see the number of likes

As a User
So that I can visit a profile page
I want to see the username in the URL

As a User
So that I can visit a profile page
I want to see only the specified user's post

As a User
So that I can visit a edit profile page
I want to see the edit profile route

As a User
So that I can change my own profile details
I want to edit my profile

As a User
So that I can only change my own profile details
I want to prevent other users from editing my profile
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
