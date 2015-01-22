class AddFieldsToObservations < ActiveRecord::Migration
  def change
    add_column :observations, :wind_speed, :float
    add_column :observations, :wind_gusts, :float
    add_column :observations, :wind_direction, :string
    add_column :observations, :mean_wind_direction, :integer
    add_column :observations, :air_temp, :float
    add_column :observations, :water_temp, :float
    add_column :observations, :log_tide_value, :float
    add_column :observations, :log_time_timestamp, :datetime
    add_column :observations, :first_low_value, :float
    add_column :observations, :first_low_timestamp, :datetime
    add_column :observations, :second_low_value, :float
    add_column :observations, :second_low_timestamp, :datetime
    add_column :observations, :first_high_value, :float
    add_column :observations, :first_high_timestamp, :datetime
    add_column :observations, :second_high_value, :float
    add_column :observations, :second_high_timestamp, :float
  end
end
