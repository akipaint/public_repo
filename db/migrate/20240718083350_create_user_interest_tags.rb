class CreateUserInterestTags < ActiveRecord::Migration[7.0]
  def change
    create_table :user_interest_tags do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.integer :interest_level, default: 0

      t.timestamps
    end
    add_index :user_interest_tags, [:user_id, :tag_id], unique: true
  end
end
