require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  before do
    user = FactoryBot.create(:user)
    @task1 = FactoryBot.create(:task, user: user)
    @task2 = FactoryBot.create(:second_task, user: user)
    @label1 = FactoryBot.create(:label, user: user)
    @label2 = FactoryBot.create(:second_label, user: user)
    FactoryBot.create(:task_label, task: @task1, label: @label1)
    FactoryBot.create(:task_label, task: @task2, label: @label2)
    visit new_session_path
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    click_button 'Log in'
    visit tasks_path
  end
  describe 'ラベル管理機能' do
    context 'ラベルを新規作成した場合' do
      it '作成したラベルがマイページに表示される'do
        visit new_label_path
        fill_in "ラベル名", with: "運動"
        click_button '登録'
        expect(page).to have_content '運動'
      end
    end
    context 'ラベルを削除した場合' do
      it 'マイページのラベル一覧から消去される' do
        click_on 'マイページ'
        label = Label.find_by(name: "ラベル１")
        page.accept_confirm do
          click_link '削除', href: label_path(label)
        end
        click_on 'マイページ'
        expect(page).not_to have_content 'ラベル１'
      end
    end
  end
  describe '検索機能' do
    context 'ラベルを検索した場合' do
      it '検索されたラベルが表示される' do
        select "ラベル１", from: "ラベル"
        click_button '検索'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'ラベル１'
        expect(task_list[0]).not_to have_content 'ラベル２'
      end
    end
  end
  describe 'タスクとラベルの関連付けチェック' do
    context 'ラベルを付けてタスクを新規作成した場合' do
      it 'ラベル付きのタスクがタスク一覧画面に表示される' do
        visit new_task_path
        fill_in "タイトル", with: "タイトル１"
        fill_in "詳細", with: "詳細１"
        fill_in "終了期限", with: "002020-12-31"
        select "着手中", from: "ステータス"
        select "高", from: "優先度"
        #検証ツールにて判明したIDを指定
        check 'task_label_ids_1'
        check 'task_label_ids_2'
        click_button '登録する'
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'ラベル１'
        expect(task_list[0]).to have_content 'ラベル２'
      end
    end
    context 'タスクを編集した場合' do
      it '任意のラベルの付け外しができる' do
        task = Task.find_by(title: "Factoryで作ったデフォルトのタイトル１")
        visit edit_task_path(task)
        check 'task_label_ids_2'
        click_button '登録する'
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[1]).to have_content 'ラベル２'
      end
    end
  end
end
