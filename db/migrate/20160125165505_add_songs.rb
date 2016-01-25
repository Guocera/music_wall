class AddSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.references :author
      t.string :url
      t.timestamps null: false
    end
  end
end
