class User < ApplicationRecord
  has_many :permissions, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def permit?(role)
    permissions.any? { |permission| permission.name.to_s == role }
  end
end
