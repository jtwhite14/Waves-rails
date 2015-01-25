class WaveSerializer < ApplicationSerializer
	include ActionView::Helpers::NumberHelper

  attributes :id, :title, :slug, :latitude, :longitude, :title_photo_url, :map_photo_url, :distance, :sessions_count

  def slug
  	object.slug.underscore.humanize if object.slug 
  end

  def distance
  	object.respond_to?(:distance) ? number_with_precision(object.distance, precision: 0) : 0
  end

  has_one :buoy
end
