class ChangeIsbnTypeInBooksBis < ActiveRecord::Migration
  def change
    change_column :books, :isbn, :decimal, :precision=>64, :scale=>0
  end
end
