class CreateTidalBuoys < ActiveRecord::Migration
  def change
    create_table :tidal_buoys do |t|
      t.string :title
      t.string :station_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
