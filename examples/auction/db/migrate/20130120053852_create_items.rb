class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.text :description, default: ''
      t.integer :bottom_price, default: 0
      t.datetime :period_at, null: false
      t.integer :seller_id, null: false

      t.timestamps
    end
  end
end
