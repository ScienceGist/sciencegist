class AddIdentifierToPaper < ActiveRecord::Migration
  def change
    add_column :papers, :identifier, :string
  end
end
