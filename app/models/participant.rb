class Participant < ActiveRecord::Base
	belongs_to :user
	belongs_to :contest

	validates_uniqueness_of :user_id, :contest_id, :message => '%{value} Você já está inscrito neste concurso!'
end
