ActiveRecord::Schema.define(version: 2019_10_29_034701) do
  
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "deadline", null: false
    t.string "priority", null: false
    t.string "status", null: false
  end

end
