class AddTimestampToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :timestamp, :datetime
  end
end
