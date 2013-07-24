class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :image, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_secret, :string
  
    User.all.each do |user|
      user.update_attribute(:name, user.email)
    end
  end

end
