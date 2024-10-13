class TagMatcher

    # タグのマッチスコアを計算するメソッド
    # source_tags: 比較対象となるタグのリスト
    # candidate_tags: 候補タグのリスト
    def calculate_match_score(source_tags, candidate_tags)
        total_similarity = 0
        comparisons = 0

        source_tags.each do |source_tag|
            if source_tag.name_en.present?
                candidate_tags.each do |candidate_tag|
                    Rails.logger.info "source_tag.name_en: #{source_tag.name_en} || candidate_tag.name_en: #{candidate_tag.name_en}"

                    # SimilarityServiceを使ってタグの類似度を計算
                    similarity = SimilarityService.get_similarity(source_tag.name_en, candidate_tag.name_en)

                    total_similarity += similarity
                    Rails.logger.info "similarity: #{similarity}"
                    comparisons += 1
                end
            end
        end

        # 類似度が1つでも計算された場合は平均を返す。そうでない場合は0を返す
        comparisons > 0 ? total_similarity / comparisons : 0
    end

    # 候補ポストのリストに対してマッチスコアを計算するメソッド
    # source_post: 比較の元となるポスト
    # candidates: マッチスコアを計算する対象の候補ポストのリスト
    def process_candidates(source_post, candidates)
        Parallel.map(candidates, in_threads: 4) do |candidate|
            # 候補ポストとソースポストのタグを使ってマッチスコアを計算
            score = calculate_match_score(source_post.tags, candidate.tags)
            Rails.logger.info "process_candidates-score: #{score}"

            # 候補ポストにマッチスコアを設定
            candidate.instance_variable_set(:@match_score, score) # 候補にマッチ度を追加
            candidate.singleton_class.class_eval { attr_reader :match_score }  # 読み取り用メソッドを動的に追加
            candidate
        end
    end
end
