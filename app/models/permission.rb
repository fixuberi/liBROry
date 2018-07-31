class Permission < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  ROLES = %w(book_editor, group_editor)
end
