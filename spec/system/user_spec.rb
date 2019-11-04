require 'rails_helper'
require 'selenium-webdriver'
require "active_support/time"
require "rack_session_access/capybara"
include SessionsHelper

RSpec.describe User, type: :system do
  describe "Userテスト" do
    before do
      @user1 = FactoryBot.create(:user,name:"test1",email:"test1@gmail.com",password:"111111",password_confirmation:"111111",admin_or_not:"true")
      @user2 = FactoryBot.create(:user,name:"test2",email:"test2@gmail.com",password:"222222",password_confirmation:"222222",admin_or_not:"false")
    end 
    
    context "sessions#newのテスト" ,driver: :webkit do
      it "ルートがログイン画面である" do
        visit root_path
        expect(page).to have_content "ログイン画面"
      end
      it "ユーザー情報が一致すればログインできる" do
        visit root_path
        fill_in "session[name]", with: "test1"
        fill_in "session[email]", with: "test1@gmail.com"
        fill_in "session[password]", with: "111111"
        click_button("ログイン")
        expect(page).to have_content "タスク一覧"
      end
      it "ユーザー情報が一致しなければログインできない" do
        visit root_path
        fill_in "session[name]", with: "test1"
        fill_in "session[email]", with: "test1@gmail.com"
        fill_in "session[password]", with: "111112"
        click_button("ログイン")
        expect(page).to_not have_content "タスク一覧"
      end
      it "ログイン状態でなければタスク一覧画面に移行できない" do
        visit root_path
        fill_in "session[name]", with: "test1"
        fill_in "session[email]", with: "test1@gmail.com"
        fill_in "session[password]", with: "111111"
        click_button("ログイン")
        visit '/tasks'
        expect(current_url).to have_content '/tasks'
        click_on("log_out_btn")
        visit '/tasks'
        expect(current_url).to_not have_content '/tasks'
      end
    end  
    context "tasks#indexのテスト" ,driver: :webkit do
      it "ログイン後ユーザー登録画面のurlに移行できない、タスク一覧画面に戻される" do
        visit root_path
        fill_in "session[name]", with: "test1"
        fill_in "session[email]", with: "test1@gmail.com"
        fill_in "session[password]", with: "111111"
        click_button("ログイン")
        visit '/users/new'
        expect(current_url).to have_content '/tasks'
      end
      it "ログイン後ログアウトできる、ユーザー登録画面のurlに移行できる" do
        visit root_path
        fill_in "session[name]", with: "test1"
        fill_in "session[email]", with: "test1@gmail.com"
        fill_in "session[password]", with: "111111"
        click_button("ログイン")
        expect(page).to have_content "タスク一覧"
        click_on("log_out_btn")
        expect(page).to_not have_content "タスク一覧"
        visit '/users/new'
        expect(current_url).to have_content '/users/new'
      end
    end
    context "users#newのテスト" ,driver: :webkit do
      it "ユーザー登録をすればログイン状態になる、ログアウトをクリックすればログアウト状態になる" do
        visit new_user_path
        fill_in "user[name]", with: "tester"
        fill_in "user[email]", with: "tester@gmail.com"
        fill_in "user[password]", with: "111111"
        fill_in "user[password_confirmation]", with: "111111"
        choose "user_admin_or_not_false"
        click_button("登録")
        @user = User.last
        page.set_rack_session(session_id: @user.id)
        visit tasks_path
        expect(page.get_rack_session.include?("user_id")).to eq true
        visit tasks_path
        click_on("log_out_btn")
        expect(page.get_rack_session.include?("user_id")).to eq false
      end
    end
  end
end
