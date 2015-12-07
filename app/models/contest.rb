class Contest < ActiveRecord::Base
  scope :closed_home, -> { where("closing < ?", Time.zone.now).limit(3) }
  has_many :participants
  has_many :users, through: :participants

  validates :title,               presence: true
  validates :description,         presence: true
  validates :opening_enrollment,  presence: true
  validates :closing_enrollment,  presence: true
  validates :opening,             presence: true
  validates :closing,             presence: true


  validates :opening_enrollment,   date: { after_or_equal_to: Time.now, before: :closing_enrollment }
  validates :opening,              date: { after_or_equal_to: Time.now, before: :closing }
  validates :closing,              date: { after_or_equal_to: Time.now }
  validates :closing_enrollment,   date: { after_or_equal_to: Time.now }


  has_attached_file(:image, {styles: { medium: "300x300>", thumb: "100x100>",
                                      large: "500x500>" }}.merge(PaperclipStorageOption.options))



  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def closed?
    self.closing < Time.zone.now
  end

  def open?
    self.opening <= Time.zone.now && self.closing >= Time.zone.now
  end

  def open_enrollment?
    self.opening_enrollment <= Time.zone.now && self.closing_enrollment >= Time.zone.now
  end

  # If current date is between closing enrollment and opening contest
  def idle?
    self.closing_enrollment <= Time.zone.now && self.opening >= Time.zone.now
  end

  def waiting?
    self.opening > Time.zone.now
  end

  def self.current
    current = where("opening <= ? AND closing >= ?", Time.zone.now, Time.zone.now).limit(1)
    if current.nil?
      current = where("opening_enrollment <= ? AND closing_enrollment >= ?", Time.zone.now, Time.zone.now).limit(1)
    end
    current.try(:first)
  end

  def self.list
    # open = where("opening <= ? AND closing >= ?", Time.zone.now, Time.zone.now)
    # open_enrollment = where("opening_enrollment <= ? AND closing_enrollment >= ?", Time.zone.now, Time.zone.now)
    # future = where("opening_enrollment > ?", Time.zone.now)
    contests = where("closing > ?", Time.zone.now).order(:opening)
  end

  def self.old
    contest = where("closing <= ?", Time.zone.now)
  end

  def self.opening_enrollment
    contests = where("opening_enrollment <= ? AND closing_enrollment >= ?", Time.zone.now, Time.zone.now)
  end

  def self.opening
    contests = where("opening <= ? AND closing >= ?", Time.zone.now, Time.zone.now)
  end

  def self.available
     contests = where("opening_enrollment <= ? AND closing >= ?", Time.zone.now, Time.zone.now)
  end

end
