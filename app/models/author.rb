# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  lastname   :string(255)
#  firstname  :string(255)
#  birthdate  :date
#  deathdate  :date
#  created_at :datetime
#  updated_at :datetime
#

class Author < ActiveRecord::Base
has_and_belongs_to_many :books

end
