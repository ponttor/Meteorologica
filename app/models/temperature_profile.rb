class TemperatureProfile < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    ['date', 'min', 'max', 'average', 'std_dev',]
  end
end
