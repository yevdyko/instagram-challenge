class User < ActiveRecord::Base
  acts_as_voter
  
  validates :username, presence: true, length: { minimum: 3, maximum: 16 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
