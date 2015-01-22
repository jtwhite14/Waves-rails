class Observation < ActiveRecord::Base
  belongs_to :buoy

  validates :timestamp, uniqueness: { scope: :buoy_id }

  #after_create :save_buoy

  def save_buoy
    # Busts the serializer cache
    self.buoy.save
  end


  def self.import! buoy
  	b = BuoyData::NoaaBuoyObservation.new(buoy.station_id)
  	unless (b.get == nil)
        observation = Observation.create(
      		timestamp: DateTime.new(b.YY.to_i, b.MM.to_i, b.DD.to_i, b.hh.to_i, 0, 0),
      		wave_height: b.WVHT,
      		swell_height: b.SwH,
      		swell_period: b.SwP,
      		wind_wave_height: b.WWH,
      		wind_wave_period: b.WWP,
      		swell_direction: b.SwD,
      		steepness: b.STEEPNESS,
      		average_wave_period: b.APD,
      		mean_wave_direction: b.MWD
      	)
        Observation.import_tidal_buoy_observation buoy.tidal_buoy, observation
        buoy.observations << observation
        buoy.update_attribute(:current_observation_id, observation.id)
      
    end
  end

  def self.import_history! buoy
  	h = BuoyData::NoaaBuoyObservation.new(buoy.station_id)
  	h.get_all(:json).each do |b|
  		begin
	  		b = JSON.parse(b)
	  		observation = buoy.observations << Observation.create(
		  		timestamp: DateTime.new(b["YY"].to_i, b["MM"].to_i, b["DD"].to_i, b["hh"].to_i, 0, 0),
		  		wave_height: b["WVHT"],
		  		swell_height: b["SwH"],
		  		swell_period: b["SwP"],
		  		wind_wave_height: b["WWH"],
		  		wind_wave_period: b["WWP"],
		  		swell_direction: b["SwD"],
		  		steepness: b["STEEPNESS"],
		  		average_wave_period: b["APD"],
		  		mean_wave_direction: b["MWD"]
		  	)
        Observation.import_tidal_buoy_observation buoy.tidal_buoy, observation
		  rescue
		  	next
		  end
		end

    def self.import_tidal_buoy_observation tidal_buoy, observation
      tidal_observation = Noaa::Tides::NoaaStationObservation.new(tidal_buoy.station_id, observation.timestamp)
      observation.update_attributes(
        air_temperature: tidal_observation.get_air_temperature["v"],
        water_temperature: tidal_observation.get_water_temperature["v"],
        wind_direction: tidal_observation.get_wind["v"],
        wind_speed: tidal_observation.get_wind["v"],
        wind_gusts: tidal_observation.get_wind["v"],
        log_tide_value: tidal_observation.get_water_level["v"],
        log_tide_timestamp: tidal_observation.get_water_level["v"],
      )

    end

  end
end
