class AddScoreToGists < ActiveRecord::Migration
  def change
    add_column :gists, :score, :integer, :default => 0
  end
end
