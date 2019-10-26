FactoryBot.define do
  
  factory :task_test, class: Task do
    task_name { "デフォルト名" }
    task_details { "デフォルトコンテント" }
  end
end
