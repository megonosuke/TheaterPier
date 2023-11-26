class AddStatusToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :is_published_flag, :boolean, default: false, null: false
  end
end
