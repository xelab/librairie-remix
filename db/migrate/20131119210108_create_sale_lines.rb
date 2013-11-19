class CreateSaleLines < ActiveRecord::Migration
  def change
    create_table :sale_lines do |t|
      t.integer :sale_id
      t.integer :book_id
      t.integer :buy_quantity
      t.integer :deposit_quantity
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
    add_index :sale_lines, :sale_id
    add_index :sale_lines, :book_id
  end
end
