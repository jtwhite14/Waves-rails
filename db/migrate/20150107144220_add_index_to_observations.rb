class AddIndexToObservations < ActiveRecord::Migration
  def change
  	add_index :observations, :timestamp
  end
end
