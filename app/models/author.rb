class Author < ApplicationRecord

  has_and_belongs_to_many :books, dependetnt: :destroy

  validates :name, presence: true, length: { maximum: 50 }

end
