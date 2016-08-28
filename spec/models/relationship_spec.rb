require 'rails_helper'

describe Relationship do
  context 'associations' do
    it do
      is_expected.to belong_to(:follower)
        .with_foreign_key('follower_id')
        .class_name('User')
    end

    it do
      is_expected.to belong_to(:following)
        .with_foreign_key('following_id')
        .class_name('User')
    end
  end
end
