class CreateMatchPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :match_posts do |t|
      t.references :image_post, null: false, foreign_key: true
      t.references :music_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
