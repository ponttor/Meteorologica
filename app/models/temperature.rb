class Temperature < ApplicationRecord
  validates :value, numericality: true, presence: true

  belongs_to :measurement, inverse_of: :temperatures

  scope :between_dates, -> (start_date, end_date) {
    joins(:measurement)
      .where('measurements.date >= ? AND measurements.date <= ?', start_date, end_date)
      .pluck('temperatures.value')
  }
end
