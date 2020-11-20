require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title:'成功テスト1', content: '成功テスト2',
                        deadline: '2020-11-28', status: '着手中', priority: '中')
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task){ FactoryBot.create(:task, title: 'task',status: '完了') }
    let!(:second_task){ FactoryBot.create(:second_task, title: 'sample', status:'完了') }
    context 'scopeメソッドでタイトル検索をした場合' do
      it '検索ワードを含んだタスクが絞られる'do
        expect(Task.search_title('task')).to include(task)
        expect(Task.search_title('task')).not_to include(second_task)
        expect(Task.search_title('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータスを検索した場合' do
      it '検索されたステータスのタスクが絞られる' do
        expect(Task.search_status('完了')).to include(task)
        expect(Task.search_status('完了')).to include(second_task)
        expect(Task.search_status('完了').count).to eq 2
      end
    end
    context 'scopeメソッドでタイトルとステータスを入力して検索した場合' do
      it '検索ワードがタイトルに含まれ、かつ選択されたステータスが一致するタスクが表示される' do
        expect(Task.search_title('sample').search_status('完了')).not_to include(task)
        expect(Task.search_title('sample').search_status('完了')).to include(second_task)
        expect(Task.search_title('sample').search_status('完了').count).to eq 1
      end
    end
  end
end
