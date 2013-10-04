class AddDepositToBooks < ActiveRecord::Migration
  def change
    add_column :books, :deposit, :integer
    add_column :books, :buy, :integer
    add_column :books, :distributor_id, :integer
    add_index :books, :distributor_id
  end
end
