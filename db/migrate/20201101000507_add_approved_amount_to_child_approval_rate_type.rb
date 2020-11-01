class AddApprovedAmountToChildApprovalRateType < ActiveRecord::Migration[6.0]
  def change
    add_column :child_approval_rate_types, :approved_amount, :decimal
  end
end
