class CreateGists < ActiveRecord::Migration
  def change
    create_table :gists do |t|
      t.integer :paper_id
      t.integer :user_id
      t.text :content
      t.text :content_html

      t.timestamps
    end
  end
end
