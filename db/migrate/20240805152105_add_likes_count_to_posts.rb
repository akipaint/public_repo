class AddLikesCountToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :image_posts, :likes_count, :integer, default: 0
    add_column :music_posts, :likes_count, :integer, default: 0
    add_column :match_posts, :likes_count, :integer, default: 0
  end
end
