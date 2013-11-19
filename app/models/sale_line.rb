# == Schema Information
#
# Table name: sale_lines
#
#  id               :integer          not null, primary key
#  sale_id          :integer
#  book_id          :integer
#  buy_quantity     :integer
#  deposit_quantity :integer
#  price            :decimal(8, 2)
#  created_at       :datetime
#  updated_at       :datetime
#

class SaleLine < ActiveRecord::Base
  belongs_to :sale
end
