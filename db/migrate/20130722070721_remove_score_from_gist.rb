class RemoveScoreFromGist < ActiveRecord::Migration
  def change
    remove_column :gists, :score, :integer
    add_column :gists, :cached_votes_total, :integer, :default => 0
    add_column :gists, :cached_votes_score, :integer, :default => 0
    add_column :gists, :cached_votes_up, :integer, :default => 0
    add_column :gists, :cached_votes_down, :integer, :default => 0
    add_index  :gists, :cached_votes_total
    add_index  :gists, :cached_votes_score
    add_index  :gists, :cached_votes_up
    add_index  :gists, :cached_votes_down
  end
end
