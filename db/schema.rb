# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_06_042724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "labelings", force: :cascade do |t|
    t.string "name", default: "-", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_labelings_on_name", unique: true
  end

  create_table "labels", force: :cascade do |t|
    t.integer "labeling_id"
    t.integer "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name", default: "-", null: false
    t.string "detail", default: "-", null: false
    t.date "deadline", default: -> { "now()" }, null: false
    t.string "status", default: "-", null: false
    t.string "priority", default: "-", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["name"], name: "index_tasks_on_name"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 30, default: "-", null: false
    t.string "email", limit: 150, default: "-", null: false
    t.string "password_digest", default: "password", null: false
    t.boolean "admin_or_not", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "tasks", "users"
end
