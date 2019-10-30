FactoryBot.define do
  
  factory :task_test, class: Task do
    name { "デフォルト名" }
    detail { "デフォルトコンテント" }
    deadline {"2100-01-01".to_date }
    priority { {"1": "高"}}
    status {"着手中"}
  end
end
