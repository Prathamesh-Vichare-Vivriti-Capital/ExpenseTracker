class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :password
      t.string :name

      t.timestamps
    end

    remove_column :users, :role
    remove_column :users, :admin_id
  end
end
