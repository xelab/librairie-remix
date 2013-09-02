# == Schema Information
#
# Table name: books
#
#  id            :integer          not null, primary key
#  isbn          :integer
#  collection_id :integer
#  publisher_id  :integer
#  price         :decimal(8, 2)
#  release       :date
#  title         :string(255)
#  summary       :text
#  created_at    :datetime
#  updated_at    :datetime
#

class Book < ActiveRecord::Base
end
