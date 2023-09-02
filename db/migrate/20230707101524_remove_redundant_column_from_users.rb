class RemoveRedundantColumnFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :add_index_to_users
  end
end
