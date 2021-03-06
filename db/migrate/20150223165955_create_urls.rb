class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :name
      t.string :original_url
      t.string :shortened_url
      t.references :user

      t.timestamps null: false
    end
  end
end
