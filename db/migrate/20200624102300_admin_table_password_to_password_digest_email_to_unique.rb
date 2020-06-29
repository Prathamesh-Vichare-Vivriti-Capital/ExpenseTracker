class AdminTablePasswordToPasswordDigestEmailToUnique < ActiveRecord::Migration[6.0]
  def change
    remove_column :admins,:password
    add_column :admins, :password_digest, :string
    add_index :admins, :email, unique: true
  end
end
