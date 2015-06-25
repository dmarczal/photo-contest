class Participant < ActiveRecord::Base
	include Paperclip::Glue
	belongs_to :user
	belongs_to :contest

	has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	
  	validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
	validates_uniqueness_of :user_id, :message => 'Você já está inscrito neste concurso!', :scope => :contest_id
	#:message => '%{value} Você já está inscrito neste concurso!',
end
