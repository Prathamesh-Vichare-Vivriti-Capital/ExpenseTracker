class CreateComments < ActiveRecord::Migration[6.0]
  def change
    drop_table :comments
    create_table :comments do |t|
      t.string :commentable_type
      t.integer :commentable_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end
end
