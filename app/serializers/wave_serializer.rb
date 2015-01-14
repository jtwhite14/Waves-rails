class WaveSerializer < ApplicationSerializer
  attributes :id, :title, :slug, :latitude, :longitude, :title_photo_url, :map_photo_url, :distance

  def slug
  	object.slug.underscore.humanize if object.slug 
  end

  def distance
  	object.respond_to?(:distance) ? object.distance : ""
  end

  has_one :buoy
end
