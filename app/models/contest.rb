class Contest < ActiveRecord::Base

  scope :closed_home, -> { where("closing < ?", Time.zone.now).limit(3) }
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

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.current
    current = where("opening <= ? AND closing >= ?", Time.zone.now, Time.zone.now).limit(1)
    if current.nil?
      current = where("opening_enrollment <= ? AND closing_enrollment >= ?", Time.zone.now, Time.zone.now).limit(1)
    end
    current.try(:first)
 end

end
