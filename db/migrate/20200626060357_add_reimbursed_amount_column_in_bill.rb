class AddReimbursedAmountColumnInBill < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :reimbursed_amount, :float
  end
end
