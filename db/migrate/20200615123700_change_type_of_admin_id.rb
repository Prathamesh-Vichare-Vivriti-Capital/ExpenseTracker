class ChangeTypeOfAdminId < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :admin_id
    change_column :users, :name, :string, null: false, default: ''
  end
end
