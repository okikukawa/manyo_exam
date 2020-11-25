require 'rails_helper'
RSpec.describe 'ユーザー管理機能'do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
  end
  describe 'ユーザー登録のテスト'do
    before do
      visit new_user_path
    end
    context '新規登録した場合'do
      it 'マイページが表示される'do
      # save_and_open_page
      fill_in "Name", with: "user1"
      fill_in "Email", with: "user1@user.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button 'Create my account'
      expect(page).to have_content 'user1'
      end
    end
    context 'ログインせずにタスク一覧画面に飛ぼうとした場合'do
      it 'ログイン画面に遷移する'do
      click_on 'タスク一覧'
      expect(page).to have_content 'Log in'
      end
    end
  end
  describe 'セッション機能のテスト'do
    before do
      visit new_session_path
      fill_in "Email", with: "testjiro@testjiro.com"
      fill_in "Password", with: "password"
      click_button 'Log in'
    end
    context 'ログインに成功した場合'do
      it 'マイページが表示される'do
      expect(page).to have_content 'テスト次郎'
      end
    end
    context '一般ユーザーが他のユーザーの詳細画面にアクセスした場合'do
      it 'フラッシュメッセージとともにタスク一覧画面を表示する'do
      visit user_path(1)
      expect(page).to have_content '権限がありません。'
      end
    end
    context 'ログアウトした場合'do
      it 'フラッシュメッセージとともにログイン画面が表示される'do
      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました。'
      end
    end
  end
end
