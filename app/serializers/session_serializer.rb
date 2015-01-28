class SessionSerializer < ApplicationSerializer
  attributes :id, :notes, :rating, :photo_url, :timestamp, :wave_id

  has_one :observation

  def wave_id
  	object.wave_id.to_s
  end

  def photo_url
  	object.session_photo.feed.url ? object.session_photo.feed.url : "" 
  end
end
