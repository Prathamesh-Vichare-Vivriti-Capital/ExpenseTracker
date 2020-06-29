class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    remove_column :bills, :reimbursed_amount
    add_column :bills, :reimbursement_amount, :float
  end
end
