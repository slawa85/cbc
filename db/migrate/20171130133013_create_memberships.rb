class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :location, index: true, foreign_key: true
      t.references :location_group, index: true, foreign_key: true
    end
  end
end
