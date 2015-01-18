class AddFinalizedToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :finalized, :boolean, default: false
  end
end
