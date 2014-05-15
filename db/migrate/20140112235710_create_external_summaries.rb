class CreateExternalSummaries < ActiveRecord::Migration
  def change
    create_table :external_summaries do |t|
      t.text :url
      t.string :category
      t.string :title

      t.timestamps
    end
  end
end
