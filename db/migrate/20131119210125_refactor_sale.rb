class RefactorSale < ActiveRecord::Migration
  def change
    remove_index :sales, :book_id
    remove_column :sales, :book_id
    remove_column :sales, :buy_quantity
    remove_column :sales, :deposit_quantity
    remove_column :sales, :price, precision: 8, scale: 2
    add_column :sales, :cancelled, :boolean
  end
end
