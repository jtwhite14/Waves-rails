class SessionSerializer < ApplicationSerializer
  attributes :id, :notes, :rating, :photo_url, :timestamp

  has_one :observation

  def photo_url
  	if Rails.env.development?
  		object.session_photo.url ? ("http://cwhite.local:3000" + object.session_photo.url) : nil
  	else
  		object.session_photo.url
  	end
  end
end
