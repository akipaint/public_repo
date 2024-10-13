class InterestTagService
    # ユーザーがいいねした投稿から興味タグを登録するメソッド
    # like: ユーザーがいいねしたオブジェクト
    def self.register_from_like(like)
        # いいねしたユーザーを取得
        user = like.user
        # いいねされた投稿を取得
        post = like.likeable

        # 投稿に関連付けられたタグをすべて処理
        post.tags.each do |tag|
            # ユーザーの興味タグを見つけるか、新しく作成する
            interest_tag = user.user_interest_tags.find_or_initialize_by(tag: tag)
            # 興味レベルをインクリメント（増加）する
            interest_tag.increment_interest
        end
    end

    # 毎日のメンテナンスを実行するメソッド
    def self.perform_daily_maintenance
        # すべての興味タグの関心度を減少させる
        UserInterestTag.decay_all_interests
        # 関心度が低いタグを削除する
        UserInterestTag.remove_low_interest_tags
    end
end
