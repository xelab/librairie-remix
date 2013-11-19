# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sale_line do
    sale_id 1
    book_id 1
    buy_quantity 1
    deposit_quantity 1
    price "9.99"
  end
end
