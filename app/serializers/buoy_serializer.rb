class BuoySerializer < ApplicationSerializer
	cached
  delegate :cache_key, to: :object

  attributes :id, :title, :description, :latitude, :longitude, :station_id

  has_one :current_observation

  def description
  	object.description ? object.description : ""
  end
end
