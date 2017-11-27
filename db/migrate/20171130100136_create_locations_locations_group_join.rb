class CreateLocationsLocationsGroupJoin < ActiveRecord::Migration
  def change
    create_table :locations_locations_group, id: false do |t|
      t.references :location, index: true, foreign_key: true
      t.references :location_group, index: true, foreign_key: true
    end
  end
end
