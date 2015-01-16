class Observation < ActiveRecord::Base
  belongs_to :buoy

  validates :timestamp, uniqueness: { scope: :buoy_id }

  after_create :save_buoy

  def save_buoy
    # Busts the serializer cache
    self.buoy.save
  end


  def self.import! buoy
  	b = BuoyData::NoaaBuoyObservation.new(buoy.station_id)
  	b.get
  	buoy.observations << Observation.create(
  		timestamp: DateTime.new(b.YY.to_i, b.MM.to_i, b.DD.to_i, b.hh.to_i, b.mm.to_i, 0),
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
  end

  def self.import_history! buoy
  	h = BuoyData::NoaaBuoyObservation.new(buoy.station_id)
  	h.get_all(:json).each do |b|
  		begin
	  		b = JSON.parse(b)
	  		buoy.observations << Observation.create(
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
		  rescue
		  	next
		  end
		end

  end
end
