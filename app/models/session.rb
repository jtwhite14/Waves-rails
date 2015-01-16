class Session < ActiveRecord::Base
  belongs_to :user
  belongs_to :wave, counter_cache: true
  belongs_to :observation

  mount_uploader :session_photo, SessionPhotoUploader
end
