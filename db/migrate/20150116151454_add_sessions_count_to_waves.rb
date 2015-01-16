class AddSessionsCountToWaves < ActiveRecord::Migration
  def change
    add_column :waves, :sessions_count, :integer
  end
end
