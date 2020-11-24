FactoryBot.define do
  factory :user do
    name { 'テスト太郎' }
    email { 'test@test.com' }
    password_digest { 'password' }
    admin { 'true' }
  end
  factory :second_user, class: User do
    name { 'テスト次郎' }
    email { 'testjiro@testjiro.com' }
    password_digest { 'password' }
    admin { 'false' }
end
