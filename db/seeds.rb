# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

data = [
  {
    code: 'DE',
    panel_provider_id: 1,
    location_groups_attributes: [
      name: 'Bavaria',
      panel_provider_id: 1,
      locations_attributes: [
        { name: 'Landshut', secret_code: 'LA' },
        { name: 'Wurzburg', secret_code: 'WU' },
        { name: 'Bayreuth', secret_code: 'BA' },
        { name: 'Ansbach', secret_code: 'AN' },
        { name: 'Regensburg', secret_code: 'RE' },
      ]
    ]
  },

  {
    code: 'FR',
    panel_provider_id: 2,
    location_groups_attributes: [
      name: 'Occitanie',
      panel_provider_id: 2,
      locations_attributes: [
        { name: 'Toulouse', secret_code: 'TU' },
        { name: 'Nimes', secret_code: 'NI' },
        { name: 'Rodez', secret_code: 'RO' },
        { name: 'Carcassonne', secret_code: 'CA' },
        { name: 'Foix', secret_code: 'FO' },
      ]
    ]
  },

  {
    code: 'RO',
    panel_provider_id: 3,
    location_groups_attributes: [
      name: 'Muntenia',
      panel_provider_id: 3,
      locations_attributes: [
        { name: 'Arges', secret_code: 'AR' },
        { name: 'Calarasi', secret_code: 'CA' },
        { name: 'Dimbovita', secret_code: 'DI' },
        { name: 'Giurgiu', secret_code: 'GI' },
        { name: 'Prahova', secret_code: 'PR' },
      ]
    ]
  }
]

panels = [
  { code: 'Panel 1', parser: 'letters' },
  { code: 'Panel 2', parser: 'arrays' },
  { code: 'Panel 3', parser: 'html_nodes' }
]
PanelProvider.create!(panels)

1.upto(3) do |i|
  User.create(email: "demo#{i}@test.com", password: "p@ssword#{i}" )
end

Country.create!(data)

LocationGroup.create({
  name: 'Brittany',
  panel_provider_id: 2,
  country: Country.find_by_code('FR'),
  locations_attributes: [
    { name: 'Rennes', secret_code: 'RE' },
    { name: 'Brest', secret_code: 'BR' },
    { name: 'Lorient', secret_code: 'LO' },
    { name: 'Quimper', secret_code: 'QI' },
    { name: 'Vannes', secret_code: 'VA' },
  ]
})

1.upto(4) do |i|
  panel = PanelProvider.find_by_id(i) || PanelProvider.first

  data = {
    name: "Target Group #{i}",
    secret_code: "TG#{1}",
    parent_id: false,
    panel_provider: panel,
    sub_groups_attributes: [
      name: "Target Group #{i}_1",
      secret_code: "TG#{i}_1",
      panel_provider: panel,
      sub_groups_attributes: [
        name: "Target Group #{i}_2",
        secret_code: "TG#{i}_2",
        panel_provider: panel,
        sub_groups_attributes: [
          name: "Target Group #{i}_2",
          secret_code: "TG#{i}_2",
          panel_provider: panel,
        ]
      ]
    ]
  }

  TargetGroup.create(data)
end

TargetGroup.all.map do |target|
  country = Country.find_by_panel_provider_id(target.panel_provider_id)
  GeoTargeting.create({
    country: country,
    target_group: target,
    target_group_root: target.parent_id.zero? ? true : false
  })
end

