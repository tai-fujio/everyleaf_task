require 'rails_helper'
require 'selenium-webdriver'
require "active_support/time"

RSpec.describe User, type: :system do
  describe "Userテスト" do
    before do
      @user1 = FactoryBot.create(:user,name:"テスト1",email:"test1@gmail.com",password:"111111",password_confirmation:"111111",admin_or_not:"true")
      @user2 = FactoryBot.create(:user,name:"テスト2",email:"test2@gmail.com",password:"222222",password_confirmation:"222222",admin_or_not:"false")
    end 
    
    context "tasks#indexのテスト" ,driver: :webkit do
      it "タスク一覧にタスク名が表示される" do
        visit tasks_path
        expect(page).to have_content "タスク名テスト1"
        expect(page).to have_content "タスク詳細テスト1"
        expect(page).to_not have_content "タスク詳細テスト6"
      end
      it "タスク一覧に終了期限が表示される" do
        visit tasks_path
        expect(page).to have_content "2099-12-31"
        expect(page).to_not have_content "2100-01-02"
      end
      it "タスク一覧にステータスが表示される" do
        visit tasks_path
        expect(page.find(".index_status",match: :first)).to have_content "着手中"
      end
      specify "検索した文字を含むレコードが一覧に表示される" do
        visit tasks_path
        fill_in "q[name_cont_all]", with: "テスト3"
        click_button("検索")
        expect(page).to have_content "テスト3"
        expect(page).to_not have_content "テスト4"
      end
      it "タスク一覧が作成日時の降順で並んでいるかのテスト" do
        visit tasks_path
        tasks = page.all(".index_name")
        expect( tasks[0].native.text ).to have_content "タスク名テスト5"
        expect(  tasks[1].native.text ).to have_content "タスク名テスト4"
        expect(  tasks[2].native.text ).to have_content "タスク名テスト3"
        expect( tasks[3].native.text ).to have_content "タスク名テスト2"
        expect(  tasks[4].native.text ).to have_content "タスク名テスト1"
        expect(  tasks[5].native.text ).to have_content "タスク名テスト0"
      end
      it "終了期限のソートが昇順に並ぶか、降順に並ぶかのテスト" do
        visit tasks_path
        click_on("終了期限")
        sleep 1
        tasks = page.all(".index_deadline")
        expect(tasks[0].native.text ).to have_content "2019-12-31"
        expect(tasks[1].native.text ).to have_content "2029-12-31"
        expect(tasks[2].native.text ).to have_content "2039-12-31"
        expect(tasks[3].native.text ).to have_content "2049-12-31"
        expect(tasks[4].native.text ).to have_content "2059-12-31"
        expect(tasks[5].native.text ).to have_content "2099-12-31"
        click_on("終了期限")
        sleep 1
        tasks = page.all(".index_deadline")
        expect(tasks[0].native.text ).to have_content "2099-12-31"
        expect(tasks[1].native.text ).to have_content "2059-12-31"
        expect(tasks[2].native.text ).to have_content "2049-12-31"
        expect(tasks[3].native.text ).to have_content "2039-12-31"
        expect(tasks[4].native.text ).to have_content "2029-12-31"
        expect(tasks[5].native.text ).to have_content "2019-12-31"
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
          expect(page).to have_content "タスク名テスト5"
          expect(page).to have_content "タスク詳細テスト5"
          expect(page).to have_content "2019-12-31"
          expect(page).to have_content "着手中"
          expect(page).not_to have_content "完了"
        end
      end
    end
  end
end
