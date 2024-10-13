class MatchingService
    # 初期化メソッド
    # candidates: マッチング対象の候補投稿のリスト
    # match_weight: マッチスコアの重み (デフォルトは0.5)
    # popularity_weight: 人気度の重み (デフォルトは0.3)
    # recency_weight: 最新度の重み (デフォルトは0.2)
    def initialize(candidates, match_weight: 0.5, popularity_weight: 0.3, recency_weight: 0.2)
        @candidates = candidates
        Rails.logger.info "MatchingService-@candidates: #{@candidates}"

        @match_weight = match_weight
        @popularity_weight = popularity_weight
        @recency_weight = recency_weight
    end

    # 指定した数のマッチング候補を選択するメソッド
    # count: 選択する候補の数 (デフォルトは3)
    def select_matches(count = 3)
        add_popularity_and_recency_scores
        calculate_selection_probabilities
        select_random_matches(count)
    end

    private

    # 人気度と最新度のスコアを候補に追加するメソッド
    def add_popularity_and_recency_scores
        # すべての候補から最大の「いいね」数を取得
        max_likes = @candidates.map(&:likes_count).max.to_f
        max_likes = 1 if max_likes.zero? || max_likes.nil?

        # 最新の投稿日時を取得
        newest_date = @candidates.map(&:created_at).max

        @candidates.each do |candidate|
            # 人気度を計算し、候補に一時的に属性を追加
            candidate.instance_variable_set(:@popularity_score, candidate.likes_count.to_f / max_likes)

            # 最新度を計算し、候補に一時的に属性を追加
            days_old = (newest_date - candidate.created_at).to_f / 1.day
            candidate.instance_variable_set(:@recency_score, 1 / (1 + days_old))

            # popularity_score と recency_score へアクセスするためのメソッドを追加
            candidate.singleton_class.class_eval do
                attr_reader :popularity_score, :recency_score
            end
        end

        Rails.logger.info "add_popularity_and_recency_scores-@candidates: #{@candidates}"
    end

    # 各候補の選択確率を計算するメソッド
    def calculate_selection_probabilities
        # 候補の重み付けスコアを合計して、全体の重みを計算
        total_weight = @candidates.sum do |c|
            @match_weight * c.match_score +
            @popularity_weight * c.popularity_score +
            @recency_weight * c.recency_score
        end

        @candidates.each do |candidate|
            # 各候補の選択確率を計算して、一時的に属性を追加
            candidate.instance_variable_set(:@selection_probability,
                (
                    @match_weight * candidate.match_score +
                    @popularity_weight * candidate.popularity_score +
                    @recency_weight * candidate.recency_score
                ) / total_weight
            )

            # selection_probability へアクセスするためのメソッドを追加
            candidate.singleton_class.class_eval do
                attr_accessor :selection_probability
            end
            Rails.logger.info "candidate.selection_probability: #{candidate.selection_probability}"
        end

        Rails.logger.info "calculate_selection_probabilities-@candidates: #{@candidates}"
    end

    # 確率に基づいて候補をランダムに選択するメソッド
    # count: 選択する候補の数
    def select_random_matches(count)
        selected = []
        Rails.logger.info "select_random_matches-@candidates: #{@candidates}"

        # 確率を正規化して合計が1になるようにする
        total_probability = @candidates.sum(&:selection_probability)
        @candidates.each do |candidate|
            candidate.selection_probability /= total_probability
        end

        count.times do
            break if @candidates.empty?

            # ランダムな値を生成
            random_value = rand
            Rails.logger.info "select_random_matches-random_value: #{random_value}"

            cumulative_probability = 0
            selected_candidate = @candidates.find do |candidate|
                cumulative_probability += candidate.selection_probability
                Rails.logger.info "candidate: #{candidate}, cumulative_probability: #{cumulative_probability}, selection_probability: #{candidate.selection_probability}"
                cumulative_probability >= random_value
            end

            if selected_candidate
                selected << selected_candidate
                Rails.logger.info "selected_candidate: #{selected_candidate}"
                @candidates.delete(selected_candidate)

                # 候補を削除した後、残りの候補の確率を再正規化
                remaining_total = @candidates.sum(&:selection_probability)
                @candidates.each do |candidate|
                    candidate.selection_probability /= remaining_total
                end
            else
                Rails.logger.warn "No candidate selected for random_value: #{random_value}"
            end
        end

        Rails.logger.info "select_random_matches-selected: #{selected}"
        selected
    end
end
