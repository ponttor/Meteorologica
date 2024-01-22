# frozen_string_literal: true

class TemperatureProfileService
  class << self
    def create_or_update_temperature_profiles(timestamps)
      dates = get_dates_from_timestamps(timestamps)
      temperature_profile_params = dates.map { |date| get_temperature_profile_params(date) }

      TemperatureProfile.upsert_all(temperature_profile_params, unique_by: :date)
    end

    def get_dates_from_timestamps(timestamps)
      timestamps.map { |timestamp| Time.at(timestamp).utc.strftime('%Y-%m-%d') }.uniq
    end

    def get_temperature_profile_params(date)
      timestamp_start = get_start_day_timestamp(date)
      timestamp_end = get_end_day_timestamp(date)

      temperature_values = Temperature.between_dates(timestamp_start, timestamp_end)
      average = temperature_values.sum / temperature_values.count

      { date:,
        min: temperature_values.min.round(1),
        max: temperature_values.max.round(1),
        average: average.round(1),
        std_dev: calculate_std_dev(temperature_values, average) }
    end

    def get_start_day_timestamp(date)
      DateTime.strptime(date, '%Y-%m-%d').to_i
    end

    def get_end_day_timestamp(date)
      DateTime.strptime(date, '%Y-%m-%d').end_of_day.to_i
    end

    def calculate_std_dev(values, average)
      return 0 if values.size <= 1

      sum_of_squares = values.sum { |value| (value - average)**2 }
      Math.sqrt(sum_of_squares / (values.size - 1)).round(1)
    end
  end
end
