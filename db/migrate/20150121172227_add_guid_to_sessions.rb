class AddGuidToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :guid, :string
    add_index :sessions, :guid
  end
end
