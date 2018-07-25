class CreateJoinTableGroupsBooks < ActiveRecord::Migration[5.2]
  def change
    create_join_table :groups, :books do |t|
       t.index [:group_id, :book_id]
       t.index [:book_id, :group_id]
    end
  end
end
