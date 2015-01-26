class Session < ActiveRecord::Base
  belongs_to :user
  belongs_to :wave
  belongs_to :observation
  counter_culture :wave
	mount_uploader :session_photo, SessionPhotoUploader
  
  default_scope { where(finalized: true) } 

  validates :wave, :presence => true
end
