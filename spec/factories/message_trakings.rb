FactoryGirl.define do
  factory :message_traking, class: 'MessageTraking' do
    sequence(:vk_user_id) { |i| "vk_user_id#{i}"}
    message_id 2
  end
end
