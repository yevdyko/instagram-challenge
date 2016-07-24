FactoryGirl.define do
  factory :post do
    sequence(:description) { |n| "This is my post #{n}"}
    image Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/test.jpg', 'image/jpg')
    created_at Time.now
    user
  end
end
