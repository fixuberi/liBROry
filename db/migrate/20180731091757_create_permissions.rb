class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.references :user, foreign_key: true
      t.boolean :group_editor, default: false
      t.boolean :book_editor, default: false
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
