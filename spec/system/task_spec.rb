require 'rails_helper'
require 'selenium-webdriver'
require "active_support/time"

RSpec.describe Task, type: :system do
  describe "Taskテスト" do
    before do
      @task_test0 = FactoryBot.create(:task_test,deadline: "2099-12-31".to_date)
      @task_test1 = FactoryBot.create(:task_test,name:"タスク名テスト1",detail:"タスク詳細テスト1")
      @task_test2 = FactoryBot.create(:task_test,name:"タスク名テスト2",detail:"タスク詳細テスト2")
      @task_test3 = FactoryBot.create(:task_test,name:"タスク名テスト3",detail:"タスク詳細テスト3")
    end  
    
    context "tasks#indexのテスト" do
      it "タスク一覧にタスク名が表示される" do
        visit tasks_path
        expect(page).to have_content "タスク名テスト1"
        expect(page).to have_content "タスク詳細テスト1"
        expect(page).to_not have_content "タスク詳細テスト4"
      end
      it "タスク一覧に終了期限が表示される" do
        visit tasks_path
        expect(page).to have_content "2099-12-31"
        expect(page).to have_content "2100-01-01"
        expect(page).to_not have_content "2100-01-02"
      end
      it "タスク一覧にステータスが表示される" do
        visit tasks_path
        expect(page.find(".index_status",match: :first)).to have_content "着手中"
      end  
    end

    context "tasks#createのテスト" ,driver: :webkit do
      it "タスク作成画面に入力した内容が新規作成される" do
        visit new_task_path
        fill_in "task_name", with: "タスク名テスト"
        fill_in "task_detail", with: "タスク詳細テスト"
        fill_in "task_deadline", with: "2050-01-01".to_date
        select "高", from: "task_priority"
        select "未着手", from:  "task_status"
        click_button("新規作成")
        expect(page.find(".show_name")).to have_content "タスク名テスト"
        expect(page.find(".show_detail")).to have_content "タスク詳細テスト"
        expect(page.find(".show_name")).to_not have_content "タスク詳細テスト"
        expect(page.find(".show_deadline")).to have_content "2050-01-01"
        expect(page.find(".show_deadline")).to_not have_content "2050-01-02"
        expect(page.find(".show_detail")).to_not have_content "タスク名テスト"
        expect(page.find(".show_status")).to have_content "未着手"
        expect(page.find(".show_status")).not_to have_content "完了"
      end
    end  

    context "tasks#showのテスト" , driver: :webkit do
      it "タスク一覧のうちタスク詳細ボタンを押すとそのタスクの詳細が表示される" do
        visit tasks_path
        first(".index_details_button").click_link("詳細")
        within_window(switch_to_window(windows.last)) do 
          expect(page).to have_content "タスク名テスト3"
          expect(page).to have_content "タスク詳細テスト3"
          expect(page).to have_content "2100-01-01"
          expect(page).to have_content "2100-01-01"
          expect(page).to have_content "着手中"
          expect(page).not_to have_content "完了"
        end
      end
    end

    context "tasks#indexのテスト" ,driver: :webkit do
      it "タスク一覧が作成日時の降順で並んでいるかのテスト" do
        visit tasks_path
        tasks = page.all(".index_name")
        expect( tasks[0].native.text ).to have_content "タスク名テスト3" 
        expect(  tasks[1].native.text ).to have_content "タスク名テスト2" 
        expect(  tasks[2].native.text ).to have_content "タスク名テスト1"
      end
    end
  end
end
