class ChangePermissionLevelToBooleanInSharedLists < ActiveRecord::Migration[8.0]
  def change
    remove_column :shared_lists, :permission_level, :integer
    add_column :shared_lists, :permission_level, :boolean, default: false, null: false
  end
end
