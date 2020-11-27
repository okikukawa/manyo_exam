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
  factory :third_user, class: User do
    name { 'テスト三郎' }
    email { 'testsaburo@testsaburo.com' }
    password { 'password' }
    admin { 'true' }
  end
  factory :forth_user, class: User do
    name { 'テスト四郎' }
    email { 'testshiro@testshiro.com' }
    password { 'password' }
    admin { 'true' }
  end
  factory :fifth_user, class: User do
    name { 'テスト五郎' }
    email { 'testgoro@testgoro.com' }
    password { 'password' }
    admin { 'true' }
  end
end
