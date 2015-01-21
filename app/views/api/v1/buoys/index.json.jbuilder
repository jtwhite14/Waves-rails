json.buoys do |json|
	json.array! @buoys do |buoy|
		json.(buoy, :id, :title, :description, :latitude, :longitude, :station_id)
		json.current_observation buoy.current_observation
	end
end