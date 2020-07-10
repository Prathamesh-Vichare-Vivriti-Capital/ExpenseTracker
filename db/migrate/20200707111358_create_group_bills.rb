class CreateGroupBills < ActiveRecord::Migration[6.0]
  def change
    create_table :group_bills do |t|
      t.string :name
      t.float :total
      t.belongs_to :user

      t.timestamps
    end
  end
end
