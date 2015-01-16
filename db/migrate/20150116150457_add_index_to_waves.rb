class AddIndexToWaves < ActiveRecord::Migration
  def change
  	add_index :waves, :latitude
  	add_index :waves, :longitude
  end
end
