require "rails_helper"

describe Post do
  context "associations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_presence_of(:user_id) }
    it do
      is_expected.to validate_length_of(:description)
        .is_at_least(3).is_at_most(300)
    end
  end
end
