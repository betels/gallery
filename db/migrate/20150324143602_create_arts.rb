class CreateArts < ActiveRecord::Migration
  def change
    create_table :arts do |t|
      t.integer :art_id
      t.string :name
      t.text :description
      t.string :catagory
      t.integer :size
      t.float :price
      t.string :url

      t.timestamps null: false
    end
  end
end
