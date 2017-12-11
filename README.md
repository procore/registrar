
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
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
gem "registrar", github: "procore/registrar"
````

Registrar comes with a handy install script. Run the installer with

```
rails generate registrar:install
```

This will do several things:
* Create a user model and table (if they do not already exist).
* Create an initializer
* Inject the sessions helper and `current_user` method into `ApplicationController`
* Mount the engine in your routes file

## Configure
Registrar also needs to have several options configured before it can run
properly.

```ruby
Registrar.configure do |config|
  # Required
  config.google_client_id = ENV.fetch("GOOGLE_CLIENT_ID")
  config.google_client_secret = ENV.fetch("GOOGLE_CLIENT_SECRET")
  config.domain = "example.com"

  # Optional
  config.whitelist += %W(person@other_domain.com)
  config.signin_url = "/signin"
  config.signout_url = "/signout"
  config.after_signin_url = "/"
  config.after_signout_url = "/signout"
  config.with_user_cookie = true
  config.redirect_uri = "https://mydomain.com/oauth/consume"
end
```

* You can get the `google_client_id` and `google_client_secret` from
  [here](wiki/for/getting/google/secrets).
* The `domain` option specifies the domain to restrict users to. In the example
  above, only users with an `example.com` email address will be allowed
  through.
* The `whitelist` option is intended allow specific users from other domains
  access to this application.
* The `with_user_cookie` option should be used when you need `cookies[:user_id]`
  to be set during your normal sessions flow.
* The `redirect_uri` option should only be used if you don't want to use the
  default of `<domain initiated from>/auth/google/callback`

## Usage
For authorization you will have an `require_signed_in_user` method available to you in your
controllers. To require that a user be logged in before viewing a particular
page you can do the following in your controller

```ruby
before_action :require_signed_in_user
```

Available Routes:

```ruby
registrar.signin_path
registrar.signout_path
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

## Licence
Registrar is copyright © 2016 Procore. It is free software, and may be redistributed under the terms specified in the LICENSE file.

## About Procore

<img
  src="https://www.procore.com/images/procore_logo.png"
  alt="Procore Logo"
  width="250px"
/>

Registrar is maintained by Procore Technologies.

Procore - building the software that builds the world.

Learn more about the #1 most widely used construction management software at [procore.com](https://www.procore.com/)
Contact us at opensource@procore.com
