# == Schema Information
#
# Table name: books
#
#  id             :integer          not null, primary key
#  isbn           :decimal(64, 12)
#  collection_id  :integer
#  publisher_id   :integer
#  price          :decimal(8, 2)
#  release        :date
#  title          :string(255)
#  summary        :text
#  created_at     :datetime
#  updated_at     :datetime
#  deposit        :integer
#  buy            :integer
#  distributor_id :integer
#

class Book < ActiveRecord::Base

  belongs_to :collection
  belongs_to :publisher
  belongs_to :distributor

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :tags

end
