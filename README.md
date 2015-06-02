# Registrar
## Getting Setup

### Add the gem to your Gemile:
  `gem "registrar", github: "procore/registrar"`

### Copy the users migration:
  `rake registrar:install:migrations`
### Run the migration:
  `bundle exec rake db:migrate`

### Mount the engine and register the callback route:
  Add

    mount Registrar::Engine, at: "/sessions"

  and

    get "/auth/google/callback", to: "registrar/sessions#create"

  to your `config/routes.rb` file

### You're done!
Now you should have easy authentication logic, with the familiar `current\_user` method available to you.
Start a rails server and visit localhost:3000/sessions to authorize!