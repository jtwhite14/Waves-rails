class AddLatAndLngToWaves < ActiveRecord::Migration
  def change
    add_column :waves, :latitude, :float
    add_column :waves, :longitude, :float
  end
end
