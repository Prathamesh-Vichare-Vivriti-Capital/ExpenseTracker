class AddingReference < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :admin
  end
end
