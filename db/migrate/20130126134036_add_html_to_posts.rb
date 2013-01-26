class AddHtmlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :html, :text
  end
end
