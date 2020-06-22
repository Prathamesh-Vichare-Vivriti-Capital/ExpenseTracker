class AddBillIdToCommentTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :user_id
    add_column :comments, :bill_id, :integer
  end
end
