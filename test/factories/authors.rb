# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :author do
    lastname "MyString"
    firstname "MyString"
    birthdate "2013-07-11"
    deathdate "2013-07-11"
  end
end
