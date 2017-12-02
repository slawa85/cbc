class LocationGroup < AbstractModel
  belongs_to :country
  belongs_to :panel_provider, required: false

  has_many :memberships
  has_many :locations, through: :memberships

  accepts_nested_attributes_for :locations, allow_destroy: true

  api_accessible :v1_default do |t|
    t.add :id
    t.add :name
    t.add :locations
  end
end
