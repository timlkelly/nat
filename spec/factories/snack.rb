FactoryGirl.define do
  factory :snack do
    sequence(:name) { |n| "snicky snack #{n}"}
    purchase_location 'Snack Store'
  end
end
