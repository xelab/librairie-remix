# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :publisher do
    name "MyString"
    address "MyText"
    city "MyString"
    zip "MyString"
    phone "MyString"
    mail "MyString"
  end
end
