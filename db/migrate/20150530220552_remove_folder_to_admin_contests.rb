class RemoveFolderToAdminContests < ActiveRecord::Migration
  def change
  	remove_column :admin_contests, :folder, :string
  end
end
