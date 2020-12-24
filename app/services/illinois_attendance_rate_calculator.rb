# frozen_string_literal: true

# Service to calculate a family's attendance rate
class IllinoisAttendanceRateCalculator
  def initialize(child, from_date)
    @child = child
    @from_date = from_date
    @current_approval = child.current_approval
  end

  def call
    return 0 unless family_days_approved.positive?

    (family_days_attended.to_f / family_days_approved).round(3)
  end

  def family_days_approved
    days = 0
    @current_approval.children.each { |child| days += sum_approvals(child) }
    days
  end

  def family_days_attended
    days = 0
    @current_approval.children.each { |child| days += sum_attendances(child) }
    days
  end

  private

  def sum_approvals(child)
    approval_amount = child.illinois_approval_amounts.find_by('month BETWEEN ? AND ?', @from_date.at_beginning_of_month, @from_date.at_end_of_month)
    return 0 unless approval_amount

    [
      approval_amount.part_days_approved_per_week * weeks_this_month,
      approval_amount.full_days_approved_per_week * weeks_this_month
    ].sum
  end

  def sum_attendances(child)
    attendances = child.attendances.for_month
    return 0 unless attendances

    [
      attendances.illinois_part_days.count,
      attendances.illinois_full_days.count,
      attendances.illinois_full_plus_part_days.count * 2,
      attendances.illinois_full_plus_full_days.count * 2
    ].sum
  end

  def weeks_this_month
    (@from_date.to_date.all_month.count / 7.0).ceil
  end
end
