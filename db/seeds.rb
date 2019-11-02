n = 0
10.times {
n += 1
name = "タスク名#{n}"
detail = "タスク詳細#{n}"
deadline = Time.now+10
priority = "1: 高"
status = "完了"
user_id = n
Task.create!(
  name: name,
  detail: detail,
  deadline: deadline,
  priority: priority,
  status: status,
  user_id: user_id)
}

# n = 0
# 10.times {
# n += 1
# name = "ユーザー#{n}"
# email = "fujio#{n}@gmail.com"
# User.create!(
#   name: name,
#   email: email,
#   password: "aaaaaa",
#   password_confirmation: "aaaaaa",
#   admin?: true)
# }
