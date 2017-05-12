FactoryGirl.define do
  factory :bot, class: 'Bot' do
    sequence(:description) { |i| "description#{i}"}
    sequence(:access_token) { |i| "access_tokendsfsdfsdfsdfsdfsdf#{i}"}
    sequence(:login_vk) { |i| "login_vk#{i}"}
    password_vk '123'
  end
end
