class Participant < ActiveRecord::Base
	include Paperclip::Glue
	belongs_to :user
	belongs_to :contest

	has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/logo.png"
  	
  	#Validation to presence true and unique ids
  	validates_uniqueness_of :user_id, :message => 'Você já está inscrito neste concurso!', :scope => :contest_id
  	validates :title, :description, :accepted_term, presence: true
  	
  	#Validation to minimum - maximum caracters lenght 
  	validates :title, length: { minimum: 3 }
  	validates :title, length: { maximum: 50 }
  	validates :description, length: { minimum: 10 }
  	validates :description, length: { maximum: 200 }

  	#Validation to picture properties
  	validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
	validates :picture, :attachment_presence => true
	validates_attachment :picture, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }, :size => { :in => 0..10.megabytes }
	
	#:message => '%{value} Você já está inscrito neste concurso!',
end
