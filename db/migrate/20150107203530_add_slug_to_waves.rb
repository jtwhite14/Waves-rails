class AddSlugToWaves < ActiveRecord::Migration
  def change
    add_column :waves, :slug, :string
    add_index :waves, :slug
  end
end
