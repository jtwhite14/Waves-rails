class UpdateSessionsCountOnWaves < ActiveRecord::Migration
  def change
  	change_column :waves, :sessions_count, :integer, default: 0
  end
end
