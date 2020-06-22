class AddReferenceOfBillInComment < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :bills_id
    add_reference :comments, :bill, foreign_key: true
  end
end
