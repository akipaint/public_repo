class MatchPost < ApplicationRecord
  belongs_to :image_post
  belongs_to :music_post

  #タグ関連
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :likes, as: :likeable, dependent: :destroy


  after_create :sync_tags_from_posts

  private

  def sync_tags_from_posts
    # 画像投稿のタグを追加
    image_post.tags.each do |tag|
      self.tags << tag unless self.tags.include?(tag)
    end

    # 音楽投稿のタグを追加
    music_post.tags.each do |tag|
      self.tags << tag unless self.tags.include?(tag)
    end
  end


  #特定のタグからの投稿を取得
  scope :with_tags, ->(tags) { joins(:tags).where(tags: {id: tags}).distinct }
  #人気度の高い投稿を取得
  scope :popular, -> { left_joins(:likes).group(:id).order('COUNT(likes.id) DESC') }
  #フォローしているユーザーがいいねした投稿を取得
  scope :liked_by_users, ->(users) { joins(:likes).where(likes: {user_id: users}).distinct }

end
