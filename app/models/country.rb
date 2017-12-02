class Country < AbstractModel
  belongs_to :panel_provider, required: false
  has_many :location_groups, dependent: :destroy
  has_many :geo_targetings, -> { where('geo_targetings.target_group_root = ?', true) }
  has_many :target_groups, through: :geo_targetings

  accepts_nested_attributes_for :location_groups, :target_groups, allow_destroy: true

  api_accessible :v1_default do |t|
    t.add :code
    t.add :location_groups
    t.add :panel_provider
  end
end
