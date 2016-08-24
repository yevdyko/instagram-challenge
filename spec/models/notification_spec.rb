require 'rails_helper'

describe Notification do
  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:notified_by).class_name('User') }
    it { is_expected.to belong_to(:post) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:notified_by_id) }
    it { is_expected.to validate_presence_of(:post_id) }
    it { is_expected.to validate_presence_of(:notice_type) }
  end
end
