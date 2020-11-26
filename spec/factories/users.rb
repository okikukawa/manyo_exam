FactoryBot.define do
  factory :user do
    name { 'テスト太郎' }
    email { 'test@test.com' }
    password { 'password' }
    admin { 'true' }
    before(:create){ User.skip_callback(:update, :before, :check_admin_count) }
    after(:create){ User.set_callback(:update, :before, :check_admin_count) }
    before(:create){ User.skip_callback(:destroy, :before, :check_admin_count) }
    after(:create){ User.set_callback(:destroy, :before, :check_admin_count) }
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
end
