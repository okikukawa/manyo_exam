FactoryBot.define do
  factory :user do
    id { '1' }
    name { 'テスト太郎' }
    email { 'test@test.com' }
    password { 'password' }
    admin { 'true' }
  end
  factory :second_user, class: User do
    id { '2' }
    name { 'テスト次郎' }
    email { 'testjiro@testjiro.com' }
    password { 'password' }
    admin { 'false' }
  end
end
