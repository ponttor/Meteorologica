class CreateTemperatures < ActiveRecord::Migration[7.0]
  def change
    create_table :temperatures do |t|
      t.references :measurement, null: false, foreign_key: true
      t.float :value, null: false

      t.timestamps
    end
  end
end
