# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_01_19_171853) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "measurements", force: :cascade do |t|
    t.bigint "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_measurements_on_date", unique: true
  end

  create_table "temperature_profiles", force: :cascade do |t|
    t.string "date", null: false
    t.float "average", null: false
    t.float "min", null: false
    t.float "max", null: false
    t.float "std_dev", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_temperature_profiles_on_date", unique: true
  end

  create_table "temperatures", force: :cascade do |t|
    t.bigint "measurement_id", null: false
    t.float "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["measurement_id"], name: "index_temperatures_on_measurement_id"
  end

  add_foreign_key "temperatures", "measurements"
end
