class ObservationSerializer < ApplicationSerializer
  attributes :id, :timestamp, :wave_height, :swell_height, :swell_period, :wind_wave_height, :wind_wave_period, :swell_direction, :steepness, :average_wave_period, :mean_wave_direction


  def wave_height
  	translate_metric_to_english(object.wave_height)
  end

  def swell_height
  	translate_metric_to_english(object.swell_height)
  end

  def translate_metric_to_english value
  	value * 3.28084
  end
end
