# == Schema Information
#
# Table name: publishers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :text
#  city       :string(255)
#  zip        :string(255)
#  phone      :string(255)
#  mail       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Publisher < ActiveRecord::Base
  has_many :collections
  has_many :books

end
