class ChangeIsbnTypeInBooks < ActiveRecord::Migration
  def change
    change_column :books, :isbn, :decimal, :precision=>64, :scale=>12
  end
end
