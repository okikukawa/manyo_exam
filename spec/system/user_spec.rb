require 'rails_helper'
RSpec.describe 'ユーザー管理機能'do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
    FactoryBot.create(:third_user)
  end
  describe 'ユーザー登録のテスト'do
    before do
      visit new_user_path
    end
    context '新規登録した場合'do
      it 'マイページが表示される'do
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
        user = User.find_by(name: "テスト太郎")
        visit user_path(user)
        expect(page).to have_content '権限がありません。'
      end
    end
    context 'ログアウトした場合'do
      it 'フラッシュメッセージとともにログイン画面が表示される'do
        page.accept_confirm do
          click_on 'ログアウト'
        end
        expect(page).to have_content 'ログアウトしました。'
      end
    end
  end
  describe '管理画面のテスト'do
    before do
      visit new_session_path
    end
    describe '管理者アカウントの操作'do
      before do
        fill_in "Email", with: "test@test.com"
        fill_in "Password", with: "password"
        click_button 'Log in'
        visit admin_users_path
      end
      context '管理画面にアクセスした場合'do
        it 'ユーザー一覧が表示される'do
          expect(page).to have_content '管理画面のユーザー一覧'
        end
        it 'ユーザーの新規登録ができる'do
          visit new_admin_user_path
          fill_in "Name", with: "user2"
          fill_in "Email", with: "user2@user.com"
          fill_in "Password", with: "password"
          fill_in "Password confirmation", with: "password"
          click_button 'ユーザーを登録する'
          expect(page).to have_content 'user2'
        end
        it 'ユーザーの詳細画面にアクセスできる'do
          user = User.find_by(name: "テスト次郎")
          visit admin_user_path(user)
          expect(page).to have_content 'ユーザー名：テスト次郎'
        end
        it 'ユーザーの編集ができる'do
          user = User.find_by(name: "テスト次郎")
          visit edit_admin_user_path(user)
          fill_in "Name", with: "テスト四郎"
          fill_in "Email", with: "testshiro@testshiro.com"
          fill_in "Password", with: "password"
          fill_in "Password confirmation", with: "password"
          click_button '編集する'
          expect(page).to have_content 'テスト四郎'
          expect(page).not_to have_content 'テスト次郎'
        end
        it 'ユーザーの削除ができる'do
          user = User.find_by(name: "テスト次郎")
          expect(page).to have_link '削除', href: admin_user_path(user)
          page.accept_confirm do
            click_link '削除', href: admin_user_path(user)
          end
          expect(page).to have_content 'ユーザーを削除しました。'
          expect(page).not_to have_content 'テスト次郎'
        end
      end
    end
    context '一般アカウントで管理画面にアクセスした場合'do
      it 'タスク一覧が表示される'do
        fill_in "Email", with: "testjiro@testjiro.com"
        fill_in "Password", with: "password"
        click_button 'Log in'
        visit admin_users_path
        expect(page).to have_content 'このユーザーにはアクセス権限がありません。'
      end
    end
  end
end
