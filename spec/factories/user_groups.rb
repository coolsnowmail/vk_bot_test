FactoryGirl.define do
    factory :user_group, class: 'UserGroup' do
      sequence(:url) { |i| 100000 + i}
      description 'user_group'
    end
end
