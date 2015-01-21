class AddSessionPhotoTmpToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :session_photo_tmp, :string
  end
end
