class CreateTargetGroups < ActiveRecord::Migration
  def change
    create_table :target_groups do |t|
      t.string :name
      t.integer :external_id, index: true, foreign_key: true
      t.integer :parent_id, index: true, foreign_key: true
      t.string :secret_code
      t.references :panel_provider, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
