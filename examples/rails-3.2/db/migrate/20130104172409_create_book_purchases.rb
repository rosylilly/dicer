class CreateBookPurchases < ActiveRecord::Migration
  def change
    create_table :book_purchases do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
