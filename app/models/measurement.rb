# frozen_string_literal: true

class Measurement < ApplicationRecord
  validates :date, presence: true, uniqueness: true
  validates :date, numericality: { only_integer: true }

  has_many :temperatures, dependent: :destroy

  scope :by_date, ->(measurement_dates) { where(date: measurement_dates) }
end
