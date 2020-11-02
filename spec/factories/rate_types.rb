# frozen_string_literal: true

FactoryBot.define do
  factory :rate_type do
    # set a decimal value 90% of the time; 10% set to nil
    name { Faker::Construction.subcontract_category }
    amount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    max_duration { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    threshold { Faker::Number.decimal(l_digits: 2, r_digits: 2) }

    factory :rate_type_illinois_half_day_under_3 do
      name { 'Illinois Half Day Rate Under 3' }
      max_duration { 4.hours.to_i }
      threshold { 0.799 }
    end
    factory :rate_type_illinois_half_day_over_3 do
      name { 'Illinois Half Day Rate Over 3' }
      max_duration { 4.hours.to_i }
      threshold { 0.799 }
    end
    factory :rate_type_illinois_full_day_under_3 do
      name { 'Illinois Full Day Rate Under 3' }
      max_duration { 8.hours.to_i }
      threshold { 0.799 }
    end
    factory :rate_type_illinois_full_day_over_3 do
      name { 'Illinois Full Day Rate Over 3' }
      max_duration { 8.hours.to_i }
      threshold { 0.799 }
    end
  end
end

# == Schema Information
#
# Table name: rate_types
#
#  id              :uuid             not null, primary key
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("USD"), not null
#  max_duration    :decimal(, )
#  name            :string           not null
#  threshold       :decimal(, )
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
