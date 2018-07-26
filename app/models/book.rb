class Book < ApplicationRecord

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :groups
  has_one_attached :cover

  validates :title, presence: true, length: { maximum: 25 }
  validates_presence_of :groups
  validates_presence_of :authors
end
