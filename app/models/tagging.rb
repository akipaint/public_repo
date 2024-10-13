class Tagging < ApplicationRecord
    belongs_to :tag
    belongs_to :taggable, polymorphic: true

    after_create :increment_tag_popularity
    after_destroy :decrement_tag_popularity

    private

    def increment_tag_popularity
        tag.increment!(:popularity)
    end

    def decrement_tag_popularity
        tag.decrement!(:popularity)
    end

end
