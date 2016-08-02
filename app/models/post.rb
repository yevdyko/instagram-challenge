class Post < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :image, presence: true
  validates_length_of :description, in: 3..300

  has_attached_file :image, styles: { medium: "600x" },
                    default_url: "missing.png"
  validates_attachment_content_type :image, content_type: %r{image/.*}
end
