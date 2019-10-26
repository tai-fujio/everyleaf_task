require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with a task_name, task_details" do
    task = Task.new(
      task_name: 'タスク名テスト',
      task_details: "タスク詳細テスト")
    expect(task).to be_valid
  end
  it "is invalid without a task_name" do
    task = Task.new(
      task_name: nil,
      task_details: "タスク詳細テスト")
    expect(task).to be_invalid
    expect(task.errors.messages[:task_name]).to include("を入力してください")
  end
  it "is invalid without a task_details" do
    task = Task.new(
      task_name: 'タスク名テスト',
      task_details: nil)
    expect(task).to be_invalid
    expect(task.errors.messages[:task_details]).to include("を入力してください")
  end
end
