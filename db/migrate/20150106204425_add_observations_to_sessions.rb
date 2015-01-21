class AddObservationsToSessions < ActiveRecord::Migration
  def change
    add_reference :sessions, :observation, index: true
  end
end
