require 'rails_helper'
require "active_support/time"

RSpec.describe Task, type: :model do
  describe 'Taskモデルバリデーションテスト' do
    it "is valid with a name, detail,deadline,priority,status" do
      task = Task.new(
        name: 'タスク名テスト',
        detail: 'タスク詳細テスト',
        deadline: Time.now+1,
        priority: '高',
        status: "完了")
      expect(task).to be_valid
    end
    it "is invalid without a name" do
      task = Task.new(
        name: nil,
        detail: 'タスク詳細テスト',
        deadline: Time.now+1,
        priority: '高',
        status: "完了")
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
    it "is invalid without a deadline" do
      task = Task.new(
        name: 'タスク名テスト',
        detail: 'タスク詳細テスト',
        deadline: nil,
        priority: '高',
        status: "完了")
      expect(task).to be_invalid
      expect(task.errors.messages[:deadline]).to include("を入力してください")
    end
    it "is invalid without a priority" do
      task = Task.new(
        name: 'タスク名テスト',
        detail: 'タスク詳細テスト',
        deadline: Time.now+1,
        priority: nil,
        status: "完了")
      expect(task).to be_invalid
      expect(task.errors.messages[:priority]).to include("を入力してください")
    end
    it "is invalid without a status" do
      task = Task.new(
        name: 'タスク名テスト',
        detail: 'タスク詳細テスト',
        deadline: Time.now+1,
        priority: '高',
        status: nil)
      expect(task).to be_invalid
      expect(task.errors.messages[:status]).to include("を入力してください")
    end
    it "is invalid without a status" do
      task = Task.new(
        name: 'タスク名テスト',
        detail: 'タスク詳細テスト',
        deadline: Time.now+1,
        priority: '高',
        status: nil)
      expect(task).to be_invalid
      expect(task.errors.messages[:status]).to include("を入力してください")
    end
    it "is invalid without a status" do
      task = Task.new(
        name: 'タスク名テスト',
        detail: 'タスク詳細テスト',
        deadline: Time.now+1,
        priority: '高',
        status: nil)
      expect(task).to be_invalid
      expect(task.errors.messages[:status]).to include("を入力してください")
    end
  end
  describe '検索ロジックテスト' do
    before do
      @task_test1 = FactoryBot.create(:task_test,name:"タスク名テスト1",detail:"タスク詳細テスト1")
      @task_test2 = FactoryBot.create(:task_test,name:"タスク名テスト2",detail:"タスク詳細テスト2")
      @task_test3 = FactoryBot.create(:task_test,name:"タスク名テスト3",detail:"タスク詳細テスト3")
      @task_test4 = FactoryBot.create(:task_test,name:"テスト4",detail:"テスト4")
      @task_test5 = FactoryBot.create(:task_test,name:"テスト5",detail:"テスト5")
    end
    it "タスク名に検索した文字を含む全てのレコードが取得できる" do
      expect(Task.search_by_name("タスク").count).to eq 3
    end
  end
end
