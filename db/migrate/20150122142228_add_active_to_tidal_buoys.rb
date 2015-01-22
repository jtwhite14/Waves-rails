class AddActiveToTidalBuoys < ActiveRecord::Migration
  def change
    add_column :tidal_buoys, :active, :boolean, default: false
  end
end
