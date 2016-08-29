require 'rails_helper'

describe User do
  context 'associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:notifications).dependent(:destroy) }

    it do
      is_expected.to have_many(:follower_relationships)
        .with_foreign_key(:following_id)
        .class_name('Relationship')
    end

    it do
      is_expected.to have_many(:followers)
        .through(:follower_relationships)
        .source(:follower)
    end

    it do
      is_expected.to have_many(:following_relationships)
        .with_foreign_key(:follower_id)
        .class_name('Relationship')
    end

    it do
      is_expected.to have_many(:followings)
        .through(:following_relationships)
        .source(:following)
    end
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:username) }
  end

  describe 'following and unfollowing other users' do
    let(:user) { create :user }
    let(:user_two) { create :user }

    context 'adds relationships between the two users' do
      before { user.follow(user_two) }

      it 'when a user follows another user' do
        expect(user.following?(user_two)).to be_truthy
        expect(user_two.followers).to include(user)
      end

      it 'when a user unfollow another user' do
        user.unfollow(user_two)

        expect(user.following?(user_two)).to be_falsy
        expect(user_two.followers).not_to include(user)
      end
    end
  end
end
