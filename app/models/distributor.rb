# == Schema Information
#
# Table name: distributors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  address    :text
#  city       :string(255)
#  zip        :string(255)
#  phone      :string(255)
#  mail       :string(255)
#

class Distributor < ActiveRecord::Base
end
