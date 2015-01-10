class SessionSerializer < ApplicationSerializer
  attributes :id, :notes, :rating, :photo_url, :timestamp

  has_one :observation

  def photo_url
  	object.session_photo.url ? ("http://cwhite.local:3000" + object.session_photo.url) : nil
  end
end
