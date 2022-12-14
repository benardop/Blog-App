class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  def retrieve_recent_posts
    posts.order(:created_at).limit(3)
  end

  validates :Name, presence: true
  # validates :PostsCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
