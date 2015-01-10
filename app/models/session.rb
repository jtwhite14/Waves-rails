class Session < ActiveRecord::Base
  belongs_to :user
  belongs_to :wave
  belongs_to :observation

  mount_uploader :session_photo, SessionPhotoUploader
end
