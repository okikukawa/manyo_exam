FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    deadline { '002020-11-25' }
    status { '未着手' }
    priority { '高' }
  end
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    deadline { '002020-11-30' }
    status { '完了' }
    priority { '中' }
  end
  factory :third_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル３' }
    content { 'Factoryで作ったデフォルトのコンテント３' }
    deadline { '002020-12-20' }
    status { '着手中' }
    priority { '低' }
  end
end
