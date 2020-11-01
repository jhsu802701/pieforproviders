class AddTimestampsToChildApprovals < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :child_approvals, default: Time.zone.now
    change_column_default :child_approvals, :created_at, from: Time.zone.now, to: nil
    change_column_default :child_approvals, :updated_at, from: Time.zone.now, to: nil
  end
end
