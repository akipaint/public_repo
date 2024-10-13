class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :image_posts
  has_many :music_posts

  has_many :likes, dependent: :destroy
  has_many :liked_image_posts, through: :likes, source: :likeable, source_type: 'ImagePost'
  has_many :liked_music_posts, through: :likes, source: :likeable, source_type: 'MusicPost'
  has_many :liked_match_posts, through: :likes, source: :likeable, source_type: 'MatchPost'


  validates :username, presence: true

  #興味タグ関連
  has_many :user_interest_tags
  has_many :interested_tags, through: :user_interest_tags, source: :tag


  #フォロー機能関連
  # フォローしている関係
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followees, through: :active_relationships, source: :followee

  # フォローされている関係
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followee_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  # フォローするメソッド
  def follow(other_user)
    active_relationships.create(followee_id: other_user.id)
  end

  # フォロー解除メソッド
  def unfollow(other_user)
    active_relationships.find_by(followee_id: other_user.id).destroy
  end

  # フォローしているか確認するメソッド
  def following?(other_user)
    followees.include?(other_user)
  end

end
