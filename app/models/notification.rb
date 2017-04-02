class Notification < ApplicationRecord
  after_create_commit { NotificationBroadcastJob.perform_later(Notification.count, self) }

  paginates_per 20

  belongs_to :user
  belongs_to :notified_by, class_name: 'User'
  belongs_to :post

  validates :user_id, :notified_by_id, :post_id, :notice_type, presence: true

  scope :unread, -> { where(read: false) }
  scope :most_recent, -> { order(created_at: :desc).limit(5) }
end
