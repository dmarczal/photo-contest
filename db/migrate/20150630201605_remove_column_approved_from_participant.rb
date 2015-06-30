class RemoveColumnApprovedFromParticipant < ActiveRecord::Migration
  def change
  	remove_column :participants, :approved, :boolean
  end
end
