class AddColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :invoice_number, :integer
    add_column :bills, :amount, :float
    add_column :bills, :date, :date
    add_column :bills, :time, :time
    add_column :bills, :description, :text
    add_column :bills, :status, :string
  end
end
