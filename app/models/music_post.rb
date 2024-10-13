class MusicPost < ApplicationRecord
    has_one_attached :music
    belongs_to :user
    has_many :match_posts
    has_many :image_posts, through: :match_posts

    #タグ関連
    has_many :taggings, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggings

    has_many :likes, as: :likeable, dependent: :destroy

    def save_tags(tags)
        # タグが存在していれば、タグの名前を配列として全て取得
        current_tags = self.tags.pluck(:name) unless self.tags.nil?
        # 現在取得したタグから送られてきたタグを除いてoldtagとする
        old_tags = current_tags - tags
        # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
        new_tags = tags - current_tags

        # 古いタグを消す
        old_tags.each do |old_name|
            self.tags.delete Tag.find_by(name:old_name)
        end

        # 新しいタグを保存
        new_tags.each do |new_name|
            music_tag = Tag.find_or_create_by(name:new_name)
            self.tags << music_tag
        end
    end
end
