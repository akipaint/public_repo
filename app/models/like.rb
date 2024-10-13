class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  after_create :register_interest_tags

  #いいねされて投稿にいいね数を反映
  after_create :increment_likes_count
  after_destroy :decrement_likes_count


  private

  def register_interest_tags
    # if self.likeable.is_a?(MatchPost)
    #   InterestTagService.register_from_like(self)
    # end
    InterestTagService.register_from_like(self)
  end

  def increment_likes_count
    likeable.increment!(:likes_count)
  end

  def decrement_likes_count
    likeable.decrement!(:likes_count)
  end



end
