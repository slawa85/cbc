class TargetGroup < AbstractModel
  belongs_to :panel_provider
  belongs_to :parent_group, class_name: 'TargetGroup', foreign_key: 'parent_id'
  has_many :sub_groups, class_name: 'TargetGroup', foreign_key: 'parent_id', dependent: :destroy
  has_many :geo_targetings
  has_many :countries, through: :geo_targetings

  accepts_nested_attributes_for :sub_groups, allow_destroy: true

  api_accessible :v1_default do |t|
    t.add :id
    t.add :name
    t.add :sub_groups
  end

  api_accessible :v1_panel_provider do |t|
    t.add :panel_provider, template: :v1_default
  end
end
