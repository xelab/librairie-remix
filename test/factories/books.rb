# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    collection_id 1
    editor_id 1
    tag_id 1
    price "9.99"
    release "2013-07-11"
    title "MyString"
    summary "MyText"
  end
end
