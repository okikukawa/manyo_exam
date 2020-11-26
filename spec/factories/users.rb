FactoryBot.define do
  factory :user do
    name { 'テスト太郎' }
    email { 'test@test.com' }
    password { 'password' }
    admin { 'true' }
  end
  factory :second_user, class: User do
    name { 'テスト次郎' }
    email { 'testjiro@testjiro.com' }
    password { 'password' }
    admin { 'false' }
  end
end
