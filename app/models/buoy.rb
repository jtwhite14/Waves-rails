class Buoy < ActiveRecord::Base
	acts_as_mappable :lat_column_name => :latitude, :lng_column_name => :longitude

	has_many :observations

	validates :station_id, uniqueness: true


	def current_observation
		self.observations.order(:timestamp).last
	end

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
