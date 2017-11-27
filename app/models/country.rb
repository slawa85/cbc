class Country < ActiveRecord::Base
  belongs_to :panel_provider
  has_many :location_groups
  has_many :geo_targetings
  has_many :target_groups, through: :geo_targetings, conditions: { geo_targetings: { 'target_group_root' => true } }
end
