FactoryGirl.define do
  factory :admin, class: 'Admin' do
    sequence(:name) { |i| "name#{i}"}
    password '123'
    password_confirmation '123'
    vk_id '12345687'
  end
end