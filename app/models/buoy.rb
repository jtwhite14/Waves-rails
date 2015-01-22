class Buoy < ActiveRecord::Base
	acts_as_mappable :default_units => :miles, :lat_column_name => :latitude, :lng_column_name => :longitude

	has_many :observations
	belongs_to :current_observation, class_name: "Observation"
	belongs_to :tidal_buoy

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

	def self.import_observations!
		buoys = Buoy.all
		buoys.each do |buoy|
			begin
				puts buoy.title
				Observation.import! buoy
				puts buoy.current_observation.inspect
			rescue
		  	next
		  end
		end
	end

	def self.import_observation_histories!
		buoys = Buoy.all
		buoys.each do |buoy|
			puts buoy.title
			Observation.import_history! buoy
		end
	end

end
