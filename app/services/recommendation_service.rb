class RecommendationService
    def self.recommend_posts_for_user(user, limit: 20)
        interested_tag_ids = user.interested_tags.order(interest_level: :desc).pluck(:id)
        following_user_ids = user.followees.pluck(:id)


        # ユーザーの興味のあるタグを持つ投稿を取得
        tag_based_posts = MatchPost.with_tags(interested_tag_ids)
        .limit(limit)


        # フォローしているユーザーがいいねした投稿を取得
        liked_posts = MatchPost.liked_by_users(following_user_ids)
        .order(created_at: :desc)
        .limit(limit)

        # 人気の投稿も含める
        popular_posts = MatchPost.popular.limit(limit / 2)

        # 新しい投稿も含める
        new_posts = MatchPost.order(created_at: :desc).limit(limit / 2)

        # 結果を組み合わせてシャッフル
        recommended_posts = (tag_based_posts + liked_posts + popular_posts + new_posts)
        .uniq
        .shuffle
        .first(limit)

    end

    def self.recommend_posts_for_guest_user(limit: 20)

        # 人気の投稿も含める
        popular_posts = MatchPost.popular.limit(limit / 2)

        # 新しい投稿も含める
        new_posts = MatchPost.order(created_at: :desc).limit(limit / 2)

        # 結果を組み合わせてシャッフル
        recommended_posts = (popular_posts + new_posts)
        .uniq
        .shuffle
        .first(limit)

    end
end
