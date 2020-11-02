# frozen_string_literal: true

FactoryBot.define do
  factory :attendance do
    check_in { Faker::Time.between(from: 5.months.ago.beginning_of_day + rand(8..20).hours, to: Time.zone.today) }
    check_out { check_in + rand(1..24).hours }

    factory :illinois_full_day_this_month do
      check_in { Faker::Time.between(from: Time.zone.today.beginning_of_month + rand(8..20).hours + rand(0..60).minutes, to: Time.zone.today) }
      check_out { check_in + rand(4..8).hours + rand(0..60).minutes }
    end

    factory :illinois_half_day_this_month do
      check_in { Faker::Time.between(from: Time.zone.today.beginning_of_month + rand(8..20).hours + rand(0..60).minutes, to: Time.zone.today) }
      check_out { check_in + rand(0..3).hours + rand(0..60).minutes }
    end
  end
end

# == Schema Information
#
# Table name: attendances
#
#  id                                                             :uuid             not null, primary key
#  check_in                                                       :datetime
#  check_out                                                      :datetime
#  total_time_in_care(Calculated: check_out time - check_in time) :interval         not null
#  created_at                                                     :datetime         not null
#  updated_at                                                     :datetime         not null
#
