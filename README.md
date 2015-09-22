# Registrar

A user authentication engine for Procore's internal apps.
Mounts a Google OAuth authentication gate that expects your Procore Gmail account.

## Getting Setup

### Add the gem to your Gemile:

```ruby
gem "registrar", github: "procore/registrar"
````

### Copy the users migration:

```
rake registrar:install:migrations
```

### Run the migration:

```
bundle exec rake db:migrate
```

### Mount the engine and register the callback route:
Add

```ruby
mount Registrar::Engine, at: "/"
```

to your `config/routes.rb` file

### Create views

Create your own layout for sign in page in `app/views/layouts/registrar.html.erb`.

Create your sign in page in `app/views/registrar/sessions/new.html.erb` (feel free to modify the template):

```erb
<%= link_to "/auth/google", "/auth/google" %>
```

### Setup the authorize filter

Add

```ruby
include Registrar::SessionsHelper
helper_method :current_user
before_action :authorize
```

to your `app/controllers/application_controller.rb` file

Now every request will require the user be logged in!

### You're done!

Now you should now have automagical authentication logic, and a `current_user` method available to you in all your controllers.

Start a rails server and visit localhost:3000/sessions/new to authorize!
