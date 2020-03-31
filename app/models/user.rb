# frozen_string_literal: true

# Application users
class User < ApplicationRecord

  validates :active, inclusion: { in: [true, false] }
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :language, presence: true
  validates :opt_in_text, inclusion: { in: [true, false] }
  validates :opt_in_email, inclusion: { in: [true, false] }
  validates :opt_in_phone, inclusion: { in: [true, false] }
  validates :service_agreement_accepted, inclusion: { in: [true, false] }
  validates :timezone, presence: true

  # format phone numbers - remove any non-digit characters
  def phone=(value)
    super(value.blank? ? nil : value.gsub(/[^\d]/, ''))
  end
end

# == Schema Information
#
# Table name: users
#
#  id                         :uuid             not null, primary key
#  active                     :boolean          default(TRUE), not null
#  email                      :string           not null
#  full_name                  :string           not null
#  greeting_name              :string
#  language                   :string           not null
#  mobile                     :string
#  opt_in_email               :boolean          default(TRUE), not null
#  opt_in_phone               :boolean          default(TRUE), not null
#  opt_in_text                :boolean          default(TRUE), not null
#  phone                      :string
#  service_agreement_accepted :boolean          default(FALSE), not null
#  timezone                   :string           not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
