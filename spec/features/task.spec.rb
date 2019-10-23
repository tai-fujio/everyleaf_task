require 'rails_helper'
require 'selenium-webdriver' 

RSpec.feature "タスク管理機能", type: :feature do
  background do
    Task.create!(task_name: "タスク名テスト", task_details: "タスク詳細テスト")
  end  
  
  scenario "タスク一覧のテスト" do
    visit tasks_path
    expect(page).to have_content "タスク名テスト"
    expect(page).to have_content "タスク詳細テスト"
    expect(page).to_not have_content "タスク詳細テストです"
  end

  scenario "タスク作成のテスト" do  
    visit new_task_path
    fill_in "task_task_name", with: 'タスク名テスト'
    fill_in "task_task_details", with: 'タスク詳細テスト'
    find(".create_task_button").click
    expect(page.find(".show_task_name")).to have_content "タスク名テスト"
    expect(page.find(".show_task_details")).to have_content "タスク詳細テスト"
    expect(page.find(".show_task_name")).to_not have_content "タスク詳細テスト"
    expect(page.find(".show_task_details")).to_not have_content "タスク名テスト"
  end  

  scenario "タスク詳細のテスト" , driver: :webkit do
    visit tasks_path
    index_task_name = page.first(".index_task_name")
    index_task_details = page.first(".index_task_details")
    page.first(".index_details_button").click
    within_window(switch_to_window(windows.last)) do 
    expect(page.find(".show_task_name")).to eq index_task_name
    expect(page.find(".show_task_details")).to eq index_task_details
    expect(page.find(".show_task_name")).to_not eq index_task_details
    expect(page.find(".show_task_details")).to_not eq index_task_name
    end
  end
end
