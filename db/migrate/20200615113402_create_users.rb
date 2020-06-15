class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null:false
      t.string :name
      t.string :role
      t.string :employment_status
      t.string :admin_id
      t.timestamps
    end
  end
end
