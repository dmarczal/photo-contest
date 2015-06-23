class Participant < ActiveRecord::Base
	belongs_to :user
	belongs_to :contest

	validates_uniqueness_of :participant_id, scope: [:user_id, :contest_id]
end
