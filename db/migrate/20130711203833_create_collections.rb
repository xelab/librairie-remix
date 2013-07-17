class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :publisher_id
      t.string :name

      t.timestamps
    end
    add_index :collections, :publisher_id
  end
end
