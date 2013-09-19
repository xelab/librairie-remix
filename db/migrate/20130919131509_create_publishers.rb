class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :name
      t.text :address
      t.string :city
      t.string :zip
      t.string :phone
      t.string :mail

      t.timestamps
    end
  end
end
