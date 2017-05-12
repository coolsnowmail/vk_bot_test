FactoryGirl.define do
    factory :user, class: 'User' do
      sequence(:vk_id) { |i| i}
      password '123'
      password_confirmation '123'
      name 'name'
    end
end