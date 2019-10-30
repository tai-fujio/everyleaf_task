require 'rails_helper'
require 'selenium-webdriver' 

RSpec.feature "タスク管理機能", type: :feature do
  background do
    @task_test1 = FactoryBot.create(:task_test,name:"タスク名テスト1",detail:"タスク詳細テスト1")
    @task_test2 = FactoryBot.create(:task_test,name:"タスク名テスト2",detail:"タスク詳細テスト2")
    @task_test3 = FactoryBot.create(:task_test,name:"タスク名テスト3",detail:"タスク詳細テスト3")
  end  
  
  scenario "タスク一覧のテスト" do
    visit tasks_path
    expect(page).to have_content "タスク名テスト1"
    expect(page).to have_content "タスク詳細テスト1"
    expect(page).to_not have_content "タスク詳細テスト4"
  end

  scenario "タスク作成のテスト" ,driver: :webkit do  
    visit new_task_path
    fill_in "task_name", with: "タスク名テスト"
    fill_in "task_detail", with: "タスク詳細テスト"
    fill_in "task_deadline", with: Time.now + 1
    select "高", from: "task_priority"
    select "着手", from:  "task_status"
    click_button("新規作成")
    expect(page.find(".show_name")).to have_content "タスク名テスト"
    expect(page.find(".show_detail")).to have_content "タスク詳細テスト"
    expect(page.find(".show_name")).to_not have_content "タスク詳細テスト"
    expect(page.find(".show_detail")).to_not have_content "タスク名テスト"
    save_and_open_page
  end  

  scenario "タスク詳細のテスト" , driver: :webkit do
    visit tasks_path
    first(".index_details_button").click_link("詳細")
    within_window(switch_to_window(windows.last)) do 
    expect(page).to have_content "タスク名テスト3"
    expect(page).to have_content "タスク詳細テスト3"
    end
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    tasks = page.all(".index_name")
    expect( tasks[0].native.children.text ).to have_content "タスク名テスト3" 
    expect(  tasks[1].native.children.text ).to have_content "タスク名テスト2" 
    expect(  tasks[2].native.children.text ).to have_content "タスク名テスト1" 
    end
end
