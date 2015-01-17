class SessionSerializer < ApplicationSerializer
  attributes :id, :notes, :rating, :photo_url, :timestamp

  belongs_to :observation
  


  def photo_url
  	object.session_photo.url
  end
end
