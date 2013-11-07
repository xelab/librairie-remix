class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :book_id
      t.integer :buy_quantity
      t.integer :deposit_quantity
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
    add_index :sales, :book_id
  end
end
