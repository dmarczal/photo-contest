class AddImageToContests < ActiveRecord::Migration
  def up
    add_attachment :contests, :image
  end

  def down
    remove_attachment :contests, :image
  end
end
