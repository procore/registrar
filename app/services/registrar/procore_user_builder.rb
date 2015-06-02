class Registrar::ProcoreUserBuilder
  attr_reader :email, :first_name, :last_name

  def initialize(user_hash)
    @email = user_hash["email"]
    @first_name = user_hash["first_name"]
    @last_name = user_hash["last_name"]
  end

  def find_or_create
    ProcoreUser.where(email: email).first_or_create(attributes)
  end

  private

  def attributes
    {
      email: email,
      first_name: first_name,
      last_name: last_name
    }
  end
end
