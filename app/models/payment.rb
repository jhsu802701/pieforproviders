# frozen_string_literal: true

# Payments made by an agency to a provide for a particular site
class Payment < UuidApplicationRecord
  belongs_to :agency
  belongs_to :site

  validates :amount, numericality: { greater_than: 0.00 }
  validates :care_finished_on, date_param: true
  validates :care_started_on, date_param: true
  validates :discrepancy, numericality: true
  validates :paid_on, date_param: true

  before_validation { |payment| payment.slug = generate_slug("#{payment.care_started_on}#{payment.site_id}#{payment.agency_id}") }

  # The money-rails gem specifically requires that the '_cents' suffix be
  # specified when using the "monetize" macro even though the attributes are
  # referred to without the '_cents' suffix.
  # IOW, you only need to refer to payment.amount or payment.discrepancy ,
  # unlike the following statements.
  monetize :amount_cents
  monetize :discrepancy_cents
end

# == Schema Information
#
# Table name: payments
#
#  id                :uuid             not null, primary key
#  amount_cents      :integer          default(0), not null
#  care_finished_on  :date             not null
#  care_started_on   :date             not null
#  discrepancy_cents :integer          default(0), not null
#  paid_on           :date             not null
#  slug              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  agency_id         :uuid             not null
#  site_id           :uuid             not null
#
# Indexes
#
#  index_payments_on_site_id                (site_id)
#  index_payments_on_site_id_and_agency_id  (site_id,agency_id)
#
