class AddAvatarToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :session_photo, :string
  end
end
