FactoryGirl.define do
  factory :group, class: 'Group' do
    sequence(:url) { |i| 100000 + i}
  end
end
