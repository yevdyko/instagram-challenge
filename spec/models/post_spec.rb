require "rails_helper"

describe Post do
  context "associations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end
end
