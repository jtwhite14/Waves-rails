class WaveSerializer < ApplicationSerializer
  attributes :id, :title, :slug, :latitude, :longitude, :title_photo_url, :map_photo_url, :distance

  def slug
  	object.slug.underscore.humanize if object.slug 
  end

  has_one :buoy
end
