class AddReferenceGroupBillToBill < ActiveRecord::Migration[6.0]
  def change
    add_reference :bills, :group_bill, index: true
  end
end
