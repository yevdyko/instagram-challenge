class User < ApplicationRecord
  acts_as_voter

  validates :username, presence: true, length: { minimum: 3, maximum: 12 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id,
                                    class_name: 'Relationship'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id,
                                     class_name: 'Relationship'
  has_many :followings, through: :following_relationships, source: :following

  has_attached_file :avatar, styles: { medium: '152x152#' }
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}

  def follow(user)
    following_relationships.create(following_id: user.id)
  end

  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  def following?(user)
    following_ids.include?(user.id)
  end

  def self.find_or_create_by(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user_attributes_from_auth(user, auth)
    end
  end

  def self.user_attributes_from_auth(user, auth)
    user.email    = auth.info.email
    user.username = auth.info.name.delete("\s").downcase
    user.password = Devise.friendly_token[0,20]
    user.avatar   = auth.info.image
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      get_data(user, session)
    end
  end

  def self.get_data(user, session)
    data = session['devise.facebook_data'] &&
           session['devise.facebook_data']['extra']['raw_info']
    return unless data
    user.email = data['email'] if user.email.blank?
  end
end
