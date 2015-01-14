class ChangeDefaultsForBuoys < ActiveRecord::Migration
  def change
  	change_column :buoys, :title, :string, default: ""
  	change_column :buoys, :description, :string, default: ""
  end
end
