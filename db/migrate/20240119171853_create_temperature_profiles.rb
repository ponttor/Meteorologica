class CreateTemperatureProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :temperature_profiles do |t|
      t.string :date, null: false
      t.float :average, null: false
      t.float :min, null: false
      t.float :max, null: false
      t.float :std_dev, null: false

      t.timestamps
    end

    add_index :temperature_profiles, :date, unique: true
  end
end
