Registrar.configure do |config|
  config.google_client_id = "client_id"
  config.google_client_secret = "client_secret"
  config.domain = "example.com"
  config.whitelist += %W(person@example.com other@example.com)
end
