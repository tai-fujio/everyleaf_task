require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    before do
      @user_test1 = FactoryBot.create(:user)
    end
    it "is valid with a name, email,password,password_confirmation,admin_or_not" do
      expect(@user_test1).to be_valid
      user = User.new(email: "test@gmail.com")
    end
    it "メールアドレスのユニーク制約テスト" do
      user = User.create(email: "test@gmail.com")
      user.valid?
      expect(user.errors.messages[:email]).to include ("はすでに存在します")
    end
    it "メールアドレスの文字制限テスト" do
      user = User.new(email: "#{"a"*151}@gmail.com")
      user.valid?
      expect(user.errors.messages[:email]).to include ("は150文字以内で入力してください")
    end
    it "パスワードの文字制限テスト" do
      user = User.new(password:"pass",password_confirmation:"pass")
      user.valid?
      expect(user.errors.messages[:password]).to include ("は6文字以上で入力してください")
    end
    it "パスワードの文字制限テスト" do
      user = User.new(password:"pass",password_confirmation:"pass")
      user.valid?
      expect(user.errors.messages[:password]).to include ("は6文字以上で入力してください")
    end
  end
  describe "メソッドテスト" do
    before do
      @user_test1 = FactoryBot.create(:user)
      @user_test2 = FactoryBot.create(:user, email:"test2@gmail.com",admin_or_not: true)
      @user_test3 = FactoryBot.create(:user, email:"test3@gmail.com",admin_or_not: true)
    end
    it "adminユーザーが残り1人の際の削除不可テスト" do
      @user_test1.destroy
      @user_test2.destroy
      @user_test3.destroy
      expect(User.count).to eq 1
      @user_test3.delete
      expect(User.count).to eq 0
    end
  end  
end
