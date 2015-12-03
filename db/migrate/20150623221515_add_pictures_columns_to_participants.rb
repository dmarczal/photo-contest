class AddPicturesColumnsToParticipants < ActiveRecord::Migration
  def change
  	add_column :participants, :approved, :boolean,  default: false
  	add_column :participants, :accepted_term, :boolean,  default: false
  	add_column :participants, :description, :text
  	add_column :participants, :picture, :text
  end
end
