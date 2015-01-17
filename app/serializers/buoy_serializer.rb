class BuoySerializer < ApplicationSerializer
	
  attributes :id, :title, :description, :latitude, :longitude, :station_id

  belongs_to :current_observation

  def description
  	object.description ? object.description : ""
  end
end
