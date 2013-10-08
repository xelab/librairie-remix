class AddFieldsToDistributors < ActiveRecord::Migration
  def change
    add_column :distributors, :address, :text
    add_column :distributors, :city, :string
    add_column :distributors, :zip, :string
    add_column :distributors, :phone, :string
    add_column :distributors, :mail, :string
  end
end
