FactoryBot.define do
  
  factory :task_test, class: Task do
    name { "デフォルト名" }
    detail { "デフォルトコンテント" }
    deadline { Time.now + 1 }
    priority { {"1": "高"}}
    status {"着手中"}
  end
end
