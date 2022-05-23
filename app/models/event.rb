class Event < ApplicationRecord
  validates :start_date, :duration, :title, :location, :description, :price, presence: true
  validates :title, length: { in: 5..140 }
  validates :description, length: { in: 20..1000 }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :start_after_now, :validate_duration, on: :create

  belongs_to :admin, class_name: "User"
  has_many :attendances
  has_many :attendees, class_name: "User", through: :attendances

  def start_after_now
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end

  def validate_duration
    if (duration.present?) && ((duration.to_i < 0) || (duration.to_i % 5 != 0))
      errors.add(:duration, "duration must be positive and by chunks of 5 min")
    end
  end

  def end_date
    self.start_date + (self.duration * 60)
  end

  def is_free?
    return self.price == 0
  end

end
