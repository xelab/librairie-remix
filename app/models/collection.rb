# == Schema Information
#
# Table name: collections
#
#  id           :integer          not null, primary key
#  publisher_id :integer
#  name         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Collection < ActiveRecord::Base
end
