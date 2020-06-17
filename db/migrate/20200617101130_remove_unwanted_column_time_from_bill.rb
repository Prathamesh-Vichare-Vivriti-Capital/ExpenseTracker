class RemoveUnwantedColumnTimeFromBill < ActiveRecord::Migration[6.0]
  def change
    remove_column :bills, :time
  end
end
