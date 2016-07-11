require "rails_helper"

describe Post do
  context "associations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  context "validations" do
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:user_id) }
  end
end
