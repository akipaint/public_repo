class CreateMusicPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :music_posts do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
