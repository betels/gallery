class CreatePurchaseHistories < ActiveRecord::Migration
  def change
    create_table :purchase_histories do |t|
      t.integer :art_id
      t.string :title
      t.float :price
      t.integer :quantity
      t.float :total
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
