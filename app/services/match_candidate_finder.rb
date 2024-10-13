class MatchCandidateFinder
    # 初期化メソッド
    # source_post: マッチングの元となる投稿
    # limit: 取得する候補の上限 (デフォルトは100)
    def initialize(source_post, limit: 100)
        @source_post = source_post
        # source_postがImagePostの場合はターゲット投稿タイプを'MusicPost'に、そうでない場合は'ImagePost'に設定
        @target_post_type = @source_post.is_a?(ImagePost) ? 'MusicPost' : 'ImagePost'

        @limit = limit
    end

    # 候補を検索するメソッド
    def find_candidates
        # source_postに関連付けられたタグを人気度の降順で取得
        ordered_tags = @source_post.tags.order(popularity: :desc)

        # ターゲット投稿タイプのモデルを動的に取得し、タグに基づいて候補を検索
        candidates = @target_post_type.constantize
            .joins(:taggings)  # タグと関連付ける
            .where(taggings: { tag_id: ordered_tags.pluck(:id) })  # source_postのタグIDに基づいてフィルタリング
            .group("#{@target_post_type.underscore.pluralize}.id")  # 投稿IDでグループ化
            .select("#{@target_post_type.underscore.pluralize}.*, COUNT(DISTINCT taggings.tag_id) as matching_tags_count")  # 各投稿のタグ一致数をカウント
            # .order(Arel.sql('COUNT(DISTINCT taggings.tag_id) DESC, MAX(tags.popularity) DESC'))  # コメントアウトされたコード（タグ一致数と人気度でソート）
            .order(Arel.sql('COUNT(DISTINCT taggings.tag_id) DESC'))  # タグ一致数の降順でソート
            .limit(@limit)  # 上限数を制限

        candidates
    end
end
