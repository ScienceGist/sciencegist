class AddPublicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :public, :boolean
  end
end
