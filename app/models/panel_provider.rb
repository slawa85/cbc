class PanelProvider < AbstractModel
  attr_reader :price

  has_many :countries
  has_many :target_groups
  has_many :location_groups

  api_accessible :v1_default do |t|
    t.add :code
    t.add :price
  end


  def price
    "#{parser}_parser".classify.constantize.call
  end
end
