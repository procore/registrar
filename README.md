
Registrar
=========

Authentication for internal tools using Gmail OAuth.

Outsource the responsibility of managing user access to Gmail. Instead of
re-writing the same simple authentication, only allow users on your Gmail
domain access to your internal tool.

Let Gmail be your active user directory. With Registrar in place, anytime
someone is given an account on your Gmail domain they will automatically have
access. This also removes the worry of deactivating a user in all the right
places - just remove them from Gmail and their access is revoked.

## Installation

Registrar is a Rails Engine. To get started, simply add it your `Gemfile` and
run `bundle install`

```ruby
gem "registrar"
````

Registrar comes with a handy install script. Run the installer with

```
rails generate registrar:install
```

This will do several things:
* Create a user model and table (if they do not already exist).
* Create an initializer
* Inject the sessions helper and current_user method into `ApplicationController`
* Mount the engine in your routes file

## Configure
Registrar also needs to have several options configured before it can run
properly.

```ruby
Registrar.configure do |config|
  config.google_client_id = "client_id"
  config.google_client_secret = "client_secret"
  config.domain = "example.com"
  config.whitelist += %W(person@other-domain.com)
end
```

* You can get the `google_client_id` and `google_client_secret` from
  [here](wiki/for/getting/google/secrets).
* The `domain` option specifies the domain to restrict users to. In the example
  above, only users with an `example.com` email address will be allowed
  through.
* The `whitelist` option is intended allow specific users from other domains
  access to this application.

## Usage
For authorization you will have an `authorized?` method available to you in your
controllers. To require that a user be logged in before viewing a particular
page you can do the following in your controller

```ruby
before_action :authorized?
```

Available Routes:

```
registrar.signin_path => "/signin"
registrar.signout_path => "/signout"
```

## Helper Methods
* `current_user` - The currently signed in user
* `signed_in?` - Returns true or false depending if the user is signed in.

## Overwriting Views

Registrar ships with very, very basic pages. To overwrite the layout create a
layout file in `app/views/layouts/registrar.html.erb`.

Overwrite the sign in page by creating a file in
`app/views/registrar/sessions/new.html.erb`.

Somewhere on the page you will need the link to authenticate:

```erb
<%= link_to "/auth/google", "/auth/google" %>
```
