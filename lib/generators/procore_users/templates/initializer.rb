Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "47720330023-fbmihitfce3vrjnol2ticonrpll14e78.apps.googleusercontent.com", "J00luebv1W9ycdZ-6YbV5W1K"
    {
    scope: "userinfo.email, userinfo.profile",
    prompt: "select_account",
    name: "google",
    image_aspect_ratio: "square",
    image_size: 50
  }
end
