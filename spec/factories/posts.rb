FactoryGirl.define do
  factory :post do
    sequence(:description) { |n| "This is my post #{n}"}
    image Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/test.jpg', 'image/jpg')
    created_at Time.now
    user
  end

  trait :with_comments do
    transient do
      comments_count 5
    end

    after :create do |post, evaluator|
      create_list(:comment, evaluator.comments_count, post: post)
    end
  end
end
