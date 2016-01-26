class AddSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.references :artist
      t.references :user
      t.string :url
      t.timestamps null: false
    end
  end
end
