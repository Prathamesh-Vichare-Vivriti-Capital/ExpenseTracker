class AddReferenceOfBillInCommentTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :bill_id
    add_reference :comments, :bills, foreign_key: true
  end
end
