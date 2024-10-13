class AddNameEnToTags < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :name_en, :string
  end
end
