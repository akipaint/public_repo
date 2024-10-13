class UserInterestTag < ApplicationRecord
    belongs_to :user
    belongs_to :tag

    validates :user_id, uniqueness: { scope: :tag_id }

    # 最小興味レベル（これ以下のタグは削除対象）
    MINIMUM_INTEREST_LEVEL = 0.1

    # 興味レベルの増加
    def increment_interest(amount = 1.0)
        self.interest_level = [interest_level + amount, 10.0].min
        self.save
    end

    # 興味レベルの減衰
    def decay_interest(decay_rate = 0.95)
        self.interest_level *= decay_rate
        save
    end

    # 低興味度タグのスコープ
    scope :low_interest, -> { where('interest_level < ?', MINIMUM_INTEREST_LEVEL) }

    # クラスメソッド：すべての興味タグの減衰を行う
    def self.decay_all_interests
        find_each do |interest_tag|
        interest_tag.decay_interest
        end
    end

    # クラスメソッド：低興味度タグの削除
    def self.remove_low_interest_tags
        low_interest.delete_all
    end

end
