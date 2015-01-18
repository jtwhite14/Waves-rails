class AddSessionsCountToWavesTwo < ActiveRecord::Migration

  def self.change
  	remove_column :waves, :sessions_count
    add_column :waves, :sessions_count, :integer, :null => false, :default => 0
  end


end
