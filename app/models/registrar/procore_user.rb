# == Schema Information
#
# Table name: procore_users
#
#  id         :integer          not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Registrar::ProcoreUser < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}".presence || email
  end
end
