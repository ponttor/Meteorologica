class CreateMeasurements < ActiveRecord::Migration[7.0]
  def change
    create_table :measurements do |t|
      t.bigint :date, null: false

      t.timestamps
    end

    add_index :measurements, :date, unique: true
  end
end
