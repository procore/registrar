Registrar.configure do |config|
  config.google_client_id = "your_client_id"
  config.google_client_secret = "your_client_secret"
  config.domain = "your_gmail_domain"
  config.whitelist += %W()
end
