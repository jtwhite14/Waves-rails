class SessionSerializer < ApplicationSerializer
  attributes :id, :notes, :rating, :photo_url, :timestamp

  has_one :observation
  belongs_to :wave, counter_cache: true


  def photo_url
  	object.session_photo.url
  end
end
