# frozen_string_literal: true

class TemperatureProfile < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[date min max average std_dev]
  end
end
