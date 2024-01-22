class CalculateTemperatureProfilesJob < ApplicationJob
  def perform(timestamp)
    TemperatureProfileService.create_or_update_temperature_profiles(timestamp)
  end
end