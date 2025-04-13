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

ActiveRecord::Schema[8.0].define(version: 2025_04_13_054813) do
  create_table "entries", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "entry_date"
    t.text "insights"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "entry_id", null: false
    t.text "challenges"
    t.text "successes"
    t.text "improvements"
    t.text "next_steps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.string "title"
    t.index ["entry_id"], name: "index_tasks_on_entry_id"
  end

  add_foreign_key "tasks", "entries"
end
