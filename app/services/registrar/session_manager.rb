class Registrar::SessionManager
  class << self
    def session_id(user)
      user.id
    end

    def find_by_session_id(session_id)
      ::User.find_by(id: session_id)
    end
  end
end
