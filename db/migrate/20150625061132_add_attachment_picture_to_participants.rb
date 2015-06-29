class AddAttachmentPictureToParticipants < ActiveRecord::Migration
  def self.up
    change_table :participants do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :participants, :picture
  end
end
