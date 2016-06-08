require "rails_helper"

describe User do
  context "associations" do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  context "validations" do
    it { should validate_presence_of(:username) }
  end
end
