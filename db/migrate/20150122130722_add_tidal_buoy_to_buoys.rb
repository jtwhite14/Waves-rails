class AddTidalBuoyToBuoys < ActiveRecord::Migration
  def change
    add_reference :buoys, :tidal_buoy, index: true
  end
end
