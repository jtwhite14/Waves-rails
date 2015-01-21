class TidalBuoy < ActiveRecord::Base
	acts_as_mappable :default_units => :miles, :lat_column_name => :latitude, :lng_column_name => :longitude

	validates :station_id, uniqueness: true

	def self.import! buoy_id=nil
		buoy_list = Noaa::Tides::NoaaStationList.new
		buoy_list.get()[:stations].each do |buoy|
			begin
				if (buoy[:latitude])
					b = TidalBuoy.create(
						title: buoy[:title],
						station_id: buoy[:station_id],
						latitude: buoy[:lat],
						longitude: buoy[:lng]
					)
				end
			rescue
				next
			end
		end
	end


end
