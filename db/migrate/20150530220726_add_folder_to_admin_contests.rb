class AddFolderToAdminContests < ActiveRecord::Migration
  def up
    add_attachment :admin_contests, :folder
  end

  def down
    remove_attachment :admin_contests, :folder
  end
end
