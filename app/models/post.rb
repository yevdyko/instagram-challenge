class Post < ApplicationRecord
  acts_as_votable

  paginates_per 12

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :user_id, presence: true
  validates :image, presence: true
  validates_length_of :description, in: 3..300

  has_attached_file :image, styles: { medium: "600x" },
                    default_url: "missing.png"
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\Z}

  scope :followed_users_or_owned_by, lambda { |user|
    where('user_id = ? or user_id = ?', user.following_ids, user.id)
  }
end
