# frozen_string_literal: true

class CalculateTemperatureProfilesJob < ApplicationJob
  def perform(timestamps)
    TemperatureProfileService.create_or_update_temperature_profiles(timestamps)
  end
end
