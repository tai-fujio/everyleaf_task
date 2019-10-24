require 'rails_helper'
require 'selenium-webdriver' 

RSpec.feature "タスク管理機能", type: :feature do
  background do
    @task_test1 = FactoryBot.create(:task_test,task_name:"タスク名テスト1",task_details:"タスク詳細テスト1")
    @task_test2 = FactoryBot.create(:task_test,task_name:"タスク名テスト2",task_details:"タスク詳細テスト2")
    @task_test3 = FactoryBot.create(:task_test,task_name:"タスク名テスト3",task_details:"タスク詳細テスト3")
  end  
  
  scenario "タスク一覧のテスト" do
    visit tasks_path
    expect(page).to have_content "タスク名テスト1"
    expect(page).to have_content "タスク詳細テスト1"
    expect(page).to_not have_content "タスク詳細テスト4"
  end

  scenario "タスク作成のテスト" ,driver: :webkit do  
    visit new_task_path
    fill_in "task_task_name", with: 'タスク名テスト'
    fill_in "task_task_details", with: 'タスク詳細テスト'
    click_button("新規作成")
    expect(page.find(".show_task_name")).to have_content "タスク名テスト"
    expect(page.find(".show_task_details")).to have_content "タスク詳細テスト"
    expect(page.find(".show_task_name")).to_not have_content "タスク詳細テスト"
    expect(page.find(".show_task_details")).to_not have_content "タスク名テスト"
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
    tasks = page.all(".index_task_name")
    expect( tasks[0].native.children.text ).to eq "タスク名テスト3" 
    expect(  tasks[1].native.children.text ).to eq "タスク名テスト2" 
    expect(  tasks[2].native.children.text ).to eq "タスク名テスト1" 
    end
  
end
