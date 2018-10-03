class Registrar::EmailChecker
  attr_reader :email

  def initialize(email)
    @email = email
  end

  def authorized?
    email_in_domain? || whitelisted_email?
  end

  private

  def email_in_domain?
    !!domain.match(/^#{Registrar.configuration.domain}$/)
  end

  def whitelisted_email?
    Registrar.configuration.whitelist.include?(email)
  end

  def domain
    email.split('@').last
  end
end
