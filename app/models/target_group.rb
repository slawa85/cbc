class TargetGroup < ActiveRecord::Base
  belongs_to :external
  belongs_to :panel_provider
  belongs_to :parent_group, class_name: 'TargetGroup', foreign_key: 'parent_id'
  has_many :sub_groups, class_name: 'TargetGroup', foreign_key: 'parent_id'
  has_many :geo_targetings
  has_many :countries, through: :geo_targetings, conditions: { geo_targetings: { 'target_group_root' => true } }
end
