class AddCurrentObservationIdToBuoys < ActiveRecord::Migration
  def change
    add_column :buoys, :current_observation_id, :integer
  end
end
