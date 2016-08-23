FactoryGirl.define do
  factory :notification do
    notified_by { create :user }
    identifier  { create :comment }
    notice_type 'comment'
    read        false
    user
    post
  end
end
