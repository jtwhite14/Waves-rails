class AddWindDegreesToObservations < ActiveRecord::Migration
  def change
    add_column :observations, :wind_degrees, :integer
  end
end
