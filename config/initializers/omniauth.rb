Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :google_oauth2,
    Registrar.configuration.google_client_id,
    Registrar.configuration.google_client_secret,
    {
      scope: "userinfo.email, userinfo.profile",
      prompt: "select_account",
      name: "google",
      image_aspect_ratio: "square",
      image_size: 50
    }
  )
end
