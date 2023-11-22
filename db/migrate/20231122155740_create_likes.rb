class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.integer :count, null: false
      t.boolean :is_bookmarked, default: true, null: false

      t.timestamps
    end
  end
end
