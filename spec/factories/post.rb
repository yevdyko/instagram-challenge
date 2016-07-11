FactoryGirl.define do
  factory :post do
    description 'This is my post'
    image Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/test.jpg', 'image/jpg')
    user_id 1
  end
end
