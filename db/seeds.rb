n = 0
50.times {
n += 1
name = "タスク名#{n}"
detail = "タスク詳細#{n}"
deadline = Time.now+10
priority = "1: 高"
status = "完了"
user_id = 1
Task.create!(
  name: name,
  detail: detail,
  deadline: deadline,
  priority: priority,
  status: status,
  user_id: user_id)
}
