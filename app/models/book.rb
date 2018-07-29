class Book < ApplicationRecord

  has_and_belongs_to_many :authors, dependent: :destroy
  has_and_belongs_to_many :groups
  has_one_attached :cover

  validates :title, presence: true, length: { maximum: 25 }
  validates_presence_of :groups
  validates_presence_of :authors

  validate :cover_presence
  validate :correct_cover_type

  private

    def cover_presence
      unless cover.attached?
        errors.add(:cover, 'Must have an image attached')
      end
    end

    def correct_cover_type
      if cover.attached? && !cover.content_type.in?(%w(image/jpeg image/png))
        errors.add(:cover, 'Image must be a JPEG or PNG')
      end
    end


end
