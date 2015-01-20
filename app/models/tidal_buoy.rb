class TidalBuoy < ActiveRecord::Base

	def self.import! buoy_id=nil
		buoy_list = Noaa::Tides::NoaaStationList.new
		buoy_list.get()[:stations].each do |buoy|
			begin
				if (buoy.latitude)
					puts buoy.inspect
					# b = TidalBuoy.create(
					# 	title: buoy[:title],
					# 	station_id: buoy[:station_id],
					# 	latitude: buoy[:lat],
					# 	longitude: buoy[:lng]
					# )
				end
				
			rescue
				next
			end
		end
	end


end
