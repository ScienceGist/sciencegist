class ChangeDefaultMetadataValue < ActiveRecord::Migration
  def change
    change_column :papers, :metadata, :hstore, default: '', null: false
  end
end
