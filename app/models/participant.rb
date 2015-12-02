include Paperclip::Glue

class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest
  has_many :votes

  has_attached_file(:picture, {
                      :styles => { :medium => "600x800>", :thumb => "100x100>", :large => '1200x800>' },
                      :default_url => "placeholder.png"
                    }.merge(PaperclipStorageOption.options))

  enum status: [ :pending, :failed, :approved ]
  
  #Validation to presence true and unique ids
  validates :title, :description, :accepted_term, presence: true
  validates_uniqueness_of :user_id, :message => 'Você já está inscrito neste concurso!', :scope => :contest_id
  
  #Validation to minimum - maximum caracters lenght 
  validates :title, length: { minimum: 3, maximum: 50}
  validates :description, length: { minimum: 10, maximum: 500}

  #Validation to picture properties
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  validates_attachment :picture,
                       :content_type => {
                          :content_type => ["image/jpeg", "image/gif", "image/png"]
                       },
                       :size => { :in => 0..20.megabytes }
  validates :picture, :attachment_presence => true

  #Check if inscription is between deadline
  def between_deadline?
    (self.contest.opening_enrollment..self.contest.closing_enrollment).cover?(Time.now) ? true : false
  end

  def self.podium contest_id
    participants = Participant.approved.where(contest_id: contest_id).limit(3)
    votes = []
    
    participants.each do |participant|

      if !votes[participant.votes.count].nil?
        aux = votes[participant.votes.count]
        
        votes[participant.votes.count] = []
        votes[participant.votes.count].push(aux)
        votes[participant.votes.count].push(participant)
      else
        votes[participant.votes.count] = participant    
      end
      
    end

  end
  
end
