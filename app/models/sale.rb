# == Schema Information
#
# Table name: sales
#
#  id               :integer          not null, primary key
#  book_id          :integer
#  buy_quantity     :integer
#  deposit_quantity :integer
#  price            :decimal(8, 2)
#  created_at       :datetime
#  updated_at       :datetime
#

class Sale < ActiveRecord::Base
end
