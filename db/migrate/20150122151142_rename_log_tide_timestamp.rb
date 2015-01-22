class RenameLogTideTimestamp < ActiveRecord::Migration
  def change
  	rename_column :observations, :log_time_timestamp, :log_tide_timestamp
  end
end
