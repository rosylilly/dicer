class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :price

      t.timestamps
    end

    add_index :bids, [:user_id, :item_id], unique: true
  end
end
