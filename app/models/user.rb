class User < ApplicationRecord
  has_one :permission, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  delegate :book_editor?, :admin?, :group_editor?, to: :permission

end
