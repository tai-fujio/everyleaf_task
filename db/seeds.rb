n = 0
80.times {
n += 1
name = "タスク名#{n}"
detail = "タスク詳細#{n}"
Task.create!(name: name,detail: detail)
}
