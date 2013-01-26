class AddPublishedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :published, :boolean
  end
end
