n = 0
80.times {
  n += 1
  task_name = "タスク名#{n}"
  task_details = "タスク詳細#{n}"
  Task.create!(task_name: task_name,task_details: task_details)
}
