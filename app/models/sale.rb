# == Schema Information
#
# Table name: sales
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  cancelled  :boolean
#

class Sale < ActiveRecord::Base

  has_many :sale_lines
end
