require 'rails_helper'
require 'selenium-webdriver'
require "active_support/time"

RSpec.describe Task, type: :system do
  before do
    @user = FactoryBot.create(:user,name:"test1",email:"test1@gmail.com",password:"111111",password_confirmation:"111111",admin_or_not:"true")
    @task_test0 = FactoryBot.create(:task_test,name:"タスク名テスト0",detail:"タスク詳細テスト0",deadline: "2099-12-31".to_date,user_id:@user.id)
    @task_test1 = FactoryBot.create(:task_test,name:"タスク名テスト1",detail:"タスク詳細テスト1",deadline: "2059-12-31".to_date,user_id:@user.id)
    @task_test2 = FactoryBot.create(:task_test,name:"タスク名テスト2",detail:"タスク詳細テスト2",deadline: "2049-12-31".to_date,user_id:@user.id)
    @task_test3 = FactoryBot.create(:task_test,name:"タスク名テスト3",detail:"タスク詳細テスト3",deadline: "2039-12-31".to_date,user_id:@user.id)
    @task_test4 = FactoryBot.create(:task_test,name:"タスク名テスト4",detail:"タスク詳細テスト4",deadline: "2029-12-31".to_date,user_id:@user.id)
    @task_test5 = FactoryBot.create(:task_test,name:"タスク名テスト5",detail:"タスク詳細テスト5",deadline: "2019-12-31".to_date,user_id:@user.id)
    @labeling1 = FactoryBot.create(:labeling,name:"仕事")
    @labeling2 = FactoryBot.create(:labeling,name:"プライベート")
    @labeling3 = FactoryBot.create(:labeling,name:"その他")
    visit root_path
    fill_in "session[name]", with: "test1"
    fill_in "session[email]", with: "test1@gmail.com"
    fill_in "session[password]", with: "111111"
    click_button("ログイン")
  end  
  describe "Taskテスト" do
    context "tasks#indexのテスト" ,driver: :webkit do
      it "タスク一覧にタスク名が表示される" do
        expect(page).to have_content "タスク名テスト1"
        expect(page).to have_content "タスク詳細テスト1"
        expect(page).to_not have_content "タスク詳細テスト6"
      end
      it "タスク一覧に終了期限が表示される" do
        expect(page).to have_content "2099-12-31"
        expect(page).to_not have_content "2100-01-02"
      end
      it "タスク一覧にステータスが表示される" do
        expect(page.find(".index_status",match: :first)).to have_content "着手中"
      end
      specify "検索した文字を含むレコードが一覧に表示される" do
        fill_in "q[name_cont_all]", with: "テスト3"
        click_button("検索")
        expect(page).to have_content "テスト3"
        expect(page).to_not have_content "テスト4"
      end
      it "タスク一覧が作成日時の降順で並んでいるかのテスト" do
        tasks = page.all(".index_name")
        expect( tasks[0].native.text ).to have_content "タスク名テスト5"
        expect(  tasks[1].native.text ).to have_content "タスク名テスト4"
        expect(  tasks[2].native.text ).to have_content "タスク名テスト3"
        expect( tasks[3].native.text ).to have_content "タスク名テスト2"
        expect(  tasks[4].native.text ).to have_content "タスク名テスト1"
        expect(  tasks[5].native.text ).to have_content "タスク名テスト0"
      end
      it "終了期限のソートが昇順に並ぶか、降順に並ぶかのテスト" do
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
    context "labels#createのテスト" ,driver: :webkit do
      it "タスクタイプを新規作成し削除する" do
        visit new_admin_labeling_path
        fill_in "labeling[name]", with: "ラベルタイプテスト"
        click_on("登録")
        expect(page).to have_content "ラベルタイプテスト"
        labelings = page.all(".labeling_delete_button")
        labelings.last.click
        page.accept_confirm "削除してもよろしいですか"
        expect(page).to_not have_content "ラベルタイプテスト"
      end
    end
    context "tasks#createのテスト" ,driver: :webkit do
      before do
        @task_test6 = FactoryBot.create(:task_test,name:"タスク名テスト6",user_id:@user.id,label_labeling_ids:[@labeling1.id])
        @task_test7 = FactoryBot.create(:task_test,name:"タスク名テスト6",user_id:@user.id,label_labeling_ids:[@labeling1.id,@labeling2.id])
        @task_test8 = FactoryBot.create(:task_test,name:"タスク名テスト6",user_id:@user.id,label_labeling_ids:[@labeling1.id,@labeling2.id,@labeling3.id])
      end
      it "タスクに複数のラベルタイプを登録できる" do
        visit new_task_path
        fill_in "task_name", with: "ラベルタイプ登録テスト"
        fill_in "task_detail", with: "タスク詳細テスト"
        fill_in "task_deadline", with: "2050-01-01".to_date
        select "高", from: "task_priority"
        select "未着手", from:  "task_status"
        check "task_label_labeling_ids_#{@labeling2.id}"
        check "task_label_labeling_ids_#{@labeling3.id}"
        click_button("新規作成")
        expect(page).to have_content "タスク詳細"
        expect(page).to have_content "プライベート"
        expect(page).to have_content "その他"
        expect(page).to_not have_content "仕事"
        visit tasks_path
        tasks = page.all(".index_tasks")
        expect(tasks[0].native.text ).to have_content "ラベルタイプ登録テスト"
        expect(tasks[0].native.text ).to have_content "プライベート"
        expect(tasks[0].native.text ).to have_content "その他"
        expect(tasks[0].native.text ).to_not have_content "仕事"
      end
      it "登録したラベルタイプがドロップダウン一覧に表示される" do
        visit tasks_path
        expect(page).to have_select("ラベルタイプ", with_options: ["仕事","プライベート","その他"])
      end
      it "検索したラベルタイプを含むタスクが一覧に表示される" do
        select("ラベルタイプ", from:"q_label_labelings_name_cont_all")
        click_button("検索")
        select("仕事", from:"q_label_labelings_name_cont_all")
        click_button("検索")
        tasks = page.all(".index_tasks")
        expect(tasks.size).to eq 3
        tasks.each do |task|
          expect(task.native.text).to have_content "仕事"
        end
        select("プライベート", from:"q_label_labelings_name_cont_all")
        click_button("検索")
        tasks = page.all(".index_tasks")
        expect(tasks.size).to eq 2
        tasks.each do |task|
          expect(task.native.text).to have_content "プライベート"
        end
      end
    end  
  end
end
