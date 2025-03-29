class CreateSharedLists < ActiveRecord::Migration[8.0]
  def change
    create_table :shared_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :todo_list, null: false, foreign_key: true
      t.integer :permission_level, default: 0

      t.timestamps
    end
  end
end
