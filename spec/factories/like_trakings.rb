FactoryGirl.define do
  factory :like_traking, class: 'LikeTraking' do
    sequence(:vk_user_id) { |i| "vk_user_id#{i}"}
    sequence(:vk_group_id) { |i| "vk_group_id#{i}"}
    offset '12'
  end
end
