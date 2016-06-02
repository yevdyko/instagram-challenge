class Post < ActiveRecord::Base
  validates :image, presence: true

  has_many :comments, dependent: :destroy
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "600x" },
                    :default_url => "missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end