class EmailChecker
  WHITELISTED_EMAILS = [
    "jeff.frost@gmail.com",
    "patrik.bona@toptal.com",
    "peter@rubytune.com",
    "sudara@rubytune.com"
  ]

  attr_reader :email

  def initialize(email)
    @email = email
  end

  def authorized?
    procore_email? || whitelisted_email?
  end

  private

  def procore_email?
    !!email.match(/@procore.com\z/)
  end

  def whitelisted_email?
    WHITELISTED_EMAILS.include?(email)
  end
end
