class TargetGroup < ActiveRecord::Base
  belongs_to :panel_provider
  belongs_to :parent_group, class_name: 'TargetGroup', foreign_key: 'parent_id'
  has_many :sub_groups, class_name: 'TargetGroup', foreign_key: 'parent_id', dependent: :destroy
  has_many :geo_targetings
  has_many :countries, through: :geo_targetings

  accepts_nested_attributes_for :sub_groups, allow_destroy: true

  scope :root_targets, ->{ where(parent_id: 0) }
end
