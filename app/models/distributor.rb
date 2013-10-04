# == Schema Information
#
# Table name: distributors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Distributor < ActiveRecord::Base
end
