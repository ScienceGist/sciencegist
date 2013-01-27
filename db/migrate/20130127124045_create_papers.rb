class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.integer :user_id
      t.string :title
      t.text :abstract
      t.text :abstract_html
      t.hstore :metadata

      t.timestamps
    end
  end
end
