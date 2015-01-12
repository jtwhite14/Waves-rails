class WaveSerializer < ApplicationSerializer
  attributes :id, :title, :slug, :latitude, :longitude

  def slug
  	object.slug.underscore.humanize if object.slug 
  end

  has_one :buoy
end
