class User < ApplicationRecord
  before_validation {email.downcase!}
  validates :name, presence: true, length: { maximum:30 }
  validates :email, presence: true, length: { maximum:255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length:{ minimum:6 }

  # before_destroy :check_admin_count
  # before_update :check_admin_count
  has_many :tasks, dependent: :destroy

  # def check_admin_count
  #   @admin_count = User.where(admin: true).count
  #   if @admin_count <= 1
  #     throw :abort, notice:"少なくとも1ユーザーは管理者権限を有する必要があります。"
  #   end
  # end
end
