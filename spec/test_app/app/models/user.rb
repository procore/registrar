class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name.try(:capitalize)} #{last_name.try(:capitalize)}".presence || email
  end
end
