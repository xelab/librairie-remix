class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :isbn
      t.integer :collection_id
      t.integer :publisher_id
      t.decimal :price, precision: 8, scale: 2
      t.date :release
      t.string :title

      t.text :summary

      t.timestamps
    end
    add_index :books, :collection_id
    add_index :books, :publisher_id
  end
end
