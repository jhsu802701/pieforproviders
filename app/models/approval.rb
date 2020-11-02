# frozen_string_literal: true

# An approval from the state to provide subsidy funding to a family's childcare provider(s)
class Approval < UuidApplicationRecord
  COPAY_FREQUENCIES = %w[daily weekly monthly].freeze

  has_many :child_approvals, dependent: :destroy
  has_many :children, through: :child_approvals
  has_many :child_approval_rate_types, through: :child_approvals
  has_many :billable_occurrences, through: :child_approvals
  has_many :rate_types, through: :child_approvals

  validates :effective_on, date_param: true
  validates :expires_on, date_param: true

  accepts_nested_attributes_for :child_approvals
  accepts_nested_attributes_for :child_approval_rate_types

  # need to do it this way because postgres/rails enums don't allow for nils
  # and there's a possibility we'll be handling approvals without copays, so
  # in order to preserve data integrity, I don't want to store false info
  enum copay_frequency: Copays.frequencies
  # validates :copay_frequency, inclusion: { in: COPAY_FREQUENCIES, allow_nil: true }

  monetize :copay_cents
end

# == Schema Information
#
# Table name: approvals
#
#  id              :uuid             not null, primary key
#  case_number     :string
#  copay_cents     :integer          default(0), not null
#  copay_currency  :string           default("USD"), not null
#  copay_frequency :enum
#  effective_on    :date
#  expires_on      :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
