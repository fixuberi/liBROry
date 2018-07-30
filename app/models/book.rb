class Book < ApplicationRecord

  has_and_belongs_to_many :authors, dependent: :destroy
  has_and_belongs_to_many :groups
  has_one_attached :cover

  validates :title, presence: true, length: { maximum: 50 }
  validates :groups, presence: true
  validates :authors, presence: true

  validate :correct_cover_type

  private

  def correct_cover_type
    if cover.attached? && !cover.content_type.in?(%w(image/jpeg image/png))
      errors.add(:cover, 'Image must be a JPEG or PNG')
    elsif cover.attached? == false
      errors.add(:cover, 'Must have an image attached')
    end
  end


end
