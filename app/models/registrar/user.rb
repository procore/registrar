# == Schema Information
#
# Table name: registrar_users
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Registrar::User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name.try(:capitalize)} #{last_name.try(:capitalize)}".presence || email
  end
end
