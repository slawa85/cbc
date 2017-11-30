class CreateGeoTargetings < ActiveRecord::Migration
  def change
    create_table :geo_targetings do |t|
      t.references :country, index: true, foreign_key: true
      t.references :target_group, index: true, foreign_key: true
      t.boolean :target_group_root
    end
  end
end
