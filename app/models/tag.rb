class Tag < ApplicationRecord
    has_many :taggings, dependent: :destroy
    has_many :image_posts, through: :taggings, source: :taggable, source_type: 'ImagePost'
    has_many :music_posts, through: :taggings, source: :taggable, source_type: 'MusicPost'
    has_many :match_posts, through: :taggings, source: :taggable, source_type: 'MatchPost'

    #興味タグ関連
    has_many :user_interest_tags
    has_many :interested_users, through: :user_interest_tags, source: :user

    after_create :initialize_popularity
    #タグの英語訳を追加する関数を呼び出す
    # after_create :translate_to_english
    after_commit :translate_to_english, on: :create


    private

    def initialize_popularity
        update(popularity: 0)
    end

    #英語訳を格納する関数
    def translate_to_english
        TranslationJob.perform_later(self.id)
    end
end
