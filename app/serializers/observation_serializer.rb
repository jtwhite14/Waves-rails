class ObservationSerializer < ApplicationSerializer
  attributes :id, :timestamp, :wave_height, :swell_height, :swell_period, :wind_wave_height, :wind_wave_period
  attributes :swell_direction, :steepness, :average_wave_period, :mean_wave_direction

  attributes :wind_speed, :wind_speed, :wind_direction, :mean_wind_direction, :air_temp, :water_temp, :log_tide_timestamp
  attributes :log_tide_value, :first_low_value, :first_low_timestamp, :second_low_value, :second_low_timestamp
  attributes :first_high_value, :first_high_timestamp, :second_high_value, :second_high_timestamp


  def wave_height
  	translate_metric_to_english(object.wave_height)
  end

  def swell_height
  	translate_metric_to_english(object.swell_height)
  end

  def translate_metric_to_english value
  	value * 3.28084
  end

  def wind_speed
    5.8
  end

  def wind_gusts
    5.9
  end

  def wind_direction
    "SW"
  end

  def mean_wind_direction
    238
  end

  def air_temp
    78
  end

  def water_temp
    76
  end

  def log_tide_timestamp
    DateTime.now
  end

  def log_tide_value
    2.3
  end

  def first_low_value
    1.2
  end

  def first_low_timestamp
    DateTime.now
  end

  def second_low_value
    1.4
  end

  def second_low_timestamp
    DateTime.now
  end

  def first_high_value
    3.6
  end

  def first_high_timestamp
    DateTime.now
  end

  def second_high_value
    3.8
  end
  
  def second_high_timestamp
    DateTime.now
  end


end
