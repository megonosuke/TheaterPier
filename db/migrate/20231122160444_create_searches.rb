class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.integer :post_id, null: false
      t.string :keyword, null: false
      t.string :tag, null: false

      t.timestamps
    end
  end
end
