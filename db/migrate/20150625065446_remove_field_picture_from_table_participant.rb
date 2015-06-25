class RemoveFieldPictureFromTableParticipant < ActiveRecord::Migration
  def change
    remove_column :participants, :picture, :text
    add_column :participants, :title, :text
  end
end
