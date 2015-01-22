class ObservationSerializer < ApplicationSerializer
  attributes :id, :timestamp, :wave_height, :swell_height, :swell_period, :wind_wave_height, :wind_wave_period
  attributes :swell_direction, :steepness, :average_wave_period, :mean_wave_direction

  attributes :wind_speed, :wind_speed, :wind_direction, :mean_wind_direction, :air_temp, :water_temp, :wind_gusts
  attributes :log_tide_timestamp, :log_tide_value, :first_low_value, :first_low_timestamp, :second_low_value, :second_low_timestamp
  attributes :first_high_value, :first_high_timestamp, :second_high_value, :second_high_timestamp


  def wave_height
  	translate_meters_to_feet(object.wave_height)
  end

  def swell_height
  	translate_meters_to_feet(object.swell_height)
  end

  def wind_speed
    kph_to_mph(object.wind_speed)
  end

  def wind_gusts
    kph_to_mph(object.wind_gusts)
  end

  def air_temp
    c_to_f(object.air_temp)
  end

  def water_temp
    c_to_f(object.water_temp)
  end

  def log_tide_value
    translate_meters_to_feet(object.log_tide_value)
  end

  def first_low_value
    translate_meters_to_feet(object.first_low_value)
  end

  def second_low_value
    translate_meters_to_feet(object.second_low_value)
  end
  
  def first_high_value
    translate_meters_to_feet(object.first_high_value)
  end

  def second_high_value
    translate_meters_to_feet(object.second_high_value)
  end

  def translate_meters_to_feet value
    value ? (value * 3.28084) : nil
  end

  def kph_to_mph value
    value ? (value * 0.621371) : nil
  end

  def c_to_f value
    value ? ((value * 9/5) + 32) : nil
  end



end
