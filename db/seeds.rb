n = 0
10.times {
n += 1
user_name = "ユーザー#{n}"
user_email = "user#{n}@gmail.com"
user_password = "password"
user_password_confirmation = "password"
user_admin_or_not = true
User.create!(
  name: user_name,
  email: user_email,
  password: user_password,
  password_confirmation: user_password_confirmation,
  admin_or_not: user_admin_or_not)
}

n = 0
10.times {
n += 1
task_name = "タスク名#{n}"
task_detail = "タスク詳細#{n}"
task_deadline = Time.now+10
task_priority = "1: 高"
task_status = "完了"
Task.create!(
  name: task_name,
  detail: task_detail,
  deadline: task_deadline,
  priority: task_priority,
  status: task_status,
  user_id: 1)
}

list = ["仕事","プライベート","その他"]
list.each do |n|
Labeling.create!(
  name: n,
  task_id: 1
)
end
