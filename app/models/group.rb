class Group < ApplicationRecord

  has_and_belongs_to_many :books

  validates :name, presence: true, length: { maximum: 25 }
end
