require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    before do
      @user = FactoryBot.create(:fifth_user)
    end
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる' do
        task = @user.tasks.create(title: '', content:'test', deadline:'002020-01-01', status:'未着手', priority:'高', user_id: '1' )
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = @user.tasks.create(title: 'test', content:'', deadline:'002020-01-01', status:'未着手', priority:'高', user_id: '1' )
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = @user.tasks.create(title: 'test', content:'test', deadline:'002020-01-01', status:'未着手', priority:'高', user_id: '1' )
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    # let!(:task){ FactoryBot.create(:task, title: 'task',status: '完了') }
    # let!(:second_task){ FactoryBot.create(:second_task, title: 'sample', status:'完了') }
    before do
      @user = FactoryBot.create(:fifth_user)
      @task = FactoryBot.create(:task,title: 'task',status: '完了', user: @user)
      @second_task = FactoryBot.create(:second_task,title: 'sample', status: '着手中', user: @user)
      @third_task = FactoryBot.create(:third_task,title: 'example', status: '着手中', user: @user)
    end
    context 'scopeメソッドでタイトル検索をした場合' do
      it '検索ワードを含んだタスクが絞られる'do
        expect(Task.search_title('task')).to include(@task)
        expect(Task.search_title('task')).not_to include(@second_task)
        expect(Task.search_title('task')).not_to include(@third_task)
        expect(Task.search_title('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータスを検索した場合' do
      it '検索されたステータスのタスクが絞られる' do
        expect(Task.search_status('着手中')).not_to include(@task)
        expect(Task.search_status('着手中')).to include(@second_task)
        expect(Task.search_status('着手中')).to include(@third_task)
        expect(Task.search_status('着手中').count).to eq 2
      end
    end
    context 'scopeメソッドでタイトルとステータスを入力して検索した場合' do
      it '検索ワードがタイトルに含まれ、かつ選択されたステータスが一致するタスクが表示される' do
        expect(Task.search_title('task').search_status('完了')).to include(@task)
        expect(Task.search_title('task').search_status('完了')).not_to include(@second_task)
        expect(Task.search_title('task').search_status('完了')).not_to include(@third_task)
        expect(Task.search_title('task').search_status('完了').count).to eq 1
      end
    end
  end
end
