class Buoy < ActiveRecord::Base
	acts_as_mappable :default_units => :miles, :lat_column_name => :latitude, :lng_column_name => :longitude

	has_many :observations
	has_one :current_observation, ->  {(order("timestamp DESC").limit(1))}, class_name: Observation

	validates :station_id, uniqueness: true



	def self.import! buoy_id=nil
		buoy_list = BuoyData::NoaaBuoyList.new
		buoy_list.get({id: buoy_id})[:stations].each do |buoy|
			begin
				b = Buoy.create(
					title: buoy[:title],
					description: buoy[:description],
					station_id: buoy[:station_id],
					latitude: buoy[:lat],
					longitude: buoy[:lng]
					)
			rescue
				next
			end
		end

	end

end
