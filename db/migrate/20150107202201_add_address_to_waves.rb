class AddAddressToWaves < ActiveRecord::Migration
  def change
    add_column :waves, :city, :string
    add_column :waves, :state, :string
    add_column :waves, :address, :string
  end
end
