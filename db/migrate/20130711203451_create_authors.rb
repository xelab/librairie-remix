class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :lastname
      t.string :firstname
      t.date :birthdate
      t.date :deathdate

      t.timestamps
    end
  end
end
