require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with a name, detail" do
    task = Task.new(
      name: 'タスク名テスト',
      detail: "タスク詳細テスト")
    expect(task).to be_valid
  end
  it "is invalid without a name" do
    task = Task.new(
      name: nil,
      detail: "タスク詳細テスト")
    expect(task).to be_invalid
    expect(task.errors.messages[:name]).to include("を入力してください")
  end
  it "is invalid without a detail" do
    task = Task.new(
      name: 'タスク名テスト',
      detail: nil)
    expect(task).to be_invalid
    expect(task.errors.messages[:detail]).to include("を入力してください")
  end
end
