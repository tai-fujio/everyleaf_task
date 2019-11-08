require 'rails_helper'
require "active_support/time"

RSpec.describe Task, type: :model do
  before do
    @user1 = FactoryBot.create(:user)
  end
  describe 'Taskモデルバリデーションテスト' do
    before do
      @task1 = FactoryBot.create(:task_test,user_id:@user1.id)
    end
    it "is valid with a name, detail,deadline,priority,status" do
      expect(@task1).to be_valid
    end
    it "is invalid without a name" do
      @task1.name = nil
      expect(@task1).to be_invalid
      expect(@task1.errors.messages[:name]).to include("を入力してください")
    end
    it "is invalid without a detail" do
      @task1.detail = nil
      expect(@task1).to be_invalid
      expect(@task1.errors.messages[:detail]).to include("を入力してください")
    end
    it "is invalid without a deadline" do
      @task1.deadline = nil
      expect(@task1).to be_invalid
      expect(@task1.errors.messages[:deadline]).to include("を入力してください")
    end
    it "is invalid without a priority" do
      @task1.priority = nil
      expect(@task1).to be_invalid
      expect(@task1.errors.messages[:priority]).to include("を入力してください")
    end
    it "is invalid without a status" do
      @task1.status = nil
      expect(@task1).to be_invalid
      expect(@task1.errors.messages[:status]).to include("を入力してください")
    end
  end
  describe '検索ロジックテスト' do
    before do
      @task1 = FactoryBot.create(:task_test,name:"タスク1",user_id:@user1.id)
      @task2 = FactoryBot.create(:task_test,name:"タスク2",user_id:@user1.id)
      @task3 = FactoryBot.create(:task_test,name:"タスク3",user_id:@user1.id)
      @task4 = FactoryBot.create(:task_test,name:"テスト1",user_id:@user1.id)
      @task5 = FactoryBot.create(:task_test,name:"テスト2",user_id:@user1.id)
    end  
    it "タスク名に検索した文字を含む全てのレコードが取得できる" do
      expect(Task.search_by_name("タスク").count).to eq 3
    end
  end
end
