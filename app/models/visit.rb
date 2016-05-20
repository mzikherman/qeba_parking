class Visit < ActiveRecord::Base
  belongs_to :owner

  scope :occupied, -> { where(end_at: nil) }

  before_validation :set_start_at
  validates :owner, presence: true
  validates_presence_of :start_at
  validate :validate_overlapping_visits

  def set_start_at
    self.start_at = Time.now if self.start_at.blank?
  end

  # Mark all visits as ended (used for EOD/BOD)
  def self.end_all_open_visits
    Visit.occupied.each(&:end!).count
  end

  def end!
    update_attributes!(end_at: Time.now)
  end

  def validate_overlapping_visits
    existing_visits = Visit.occupied.where(owner: owner)
    existing_visits = existing_visits.where("id != ?", self.id) if self.persisted?
    current_time = Time.now
    if [0, 6].include? current_time.wday
      errors.add(:base, 'This pass is already in use') if existing_visits.any?
    else
      errors.add(:base, 'This pass is already in use') if existing_visits.count > 1
    end
  end
end
