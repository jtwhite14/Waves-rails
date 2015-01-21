class SessionSerializer < ApplicationSerializer
  attributes :id, :notes, :rating, :photo_url, :timestamp

  has_one :observation
  


  def photo_url
  	object.session_photo.url ? object.session_photo.url : "" 
  end
end
