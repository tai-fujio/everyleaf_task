FactoryBot.define do
  
  factory :task_test, class: Task do
    name { "デフォルト名" }
    detail { "デフォルトコンテント" }
  end
end
