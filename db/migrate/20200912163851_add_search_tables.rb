class AddSearchTables < ActiveRecord::Migration[6.0]
  def change
    create_table :search_items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :query
      t.timestamps
    end

    create_table :search_results do |t|
      t.references :search_item, null: false, foreign_key: true
      t.string :twitter_id_number
      t.string :twitter_screen_name
      t.timestamps
    end
  end
end
