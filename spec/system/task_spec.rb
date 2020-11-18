require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task){ FactoryBot.create(:task,title:'task') }
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タイトル", with: "リュック買う"
        fill_in "詳細", with: "メルカリで見てみる"
        fill_in "終了期限", with: "002020-11-18"
        select "着手中", from: "ステータス"
        click_button '登録する'
        expect(page).to have_content 'リュック買う'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順で並んでいた場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル２'
      end
    end
    context 'タスクの終了期限でを降順でソートした場合' do
      it '終了期限が一番遠いタスクが一番上に表示される' do
        visit new_task_path
        fill_in "タイトル", with: "step3終わらせる"
        fill_in "詳細", with: "最後にpullrequestを忘れない"
        fill_in "終了期限", with: "002020-11-18"
        select "着手中", from: "ステータス"
        click_button '登録する'
        visit tasks_path
        click_on '終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル２'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, title: 'task')
         visit task_path(task.id)
         expect(page).to have_content 'task'
       end
     end
  end
  describe '検索機能' do
    before do
      visit tasks_path
    end
    context 'タイトルを検索した場合' do
      it '検索ワードを含んだタスクが表示される'do
        fill_in "search_textarea", with:"タイトル２"
        click_button '検索'
        expect(page).to have_content 'タイトル２'
      end
    end
    context 'ステータスを検索した場合' do
      it '検索されたステータスのタスクが表示される'do
        select "未着手", from: "search_status"
        click_button '検索'
        expect(page).to have_content 'task'
      end
    end
    context 'タイトルとステータスを入力して検索した場合' do
      it '検索ワードがタイトルに含まれ、かつ選択されたステータスが一致するタスクが絞られる'do
        fill_in "search_textarea", with:"タイトル１"
        select "未着手", from: "search_status"
        click_button '検索'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
        # save_and_open_page
      end
    end
  end
end
