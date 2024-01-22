# frozen_string_literal: true

class MeasurementService
  class << self
    def get_measurement_attributes(measurement_params)
      existing_timestamps = Measurement.pluck(:date)
      measurement_params.reject { |param| existing_timestamps.include?(param[:date]) }
                        .map { |param| { date: param[:date] } }
    end

    def get_temperature_attributes(measurement_params, imported_measurements)
      measurement_params.flat_map do |param|
        matched_measurement = imported_measurements.results.find { |m| m.last == param[:date] }
        next [] unless matched_measurement

        param[:measurements].map do |temp_value|
          { measurement_id: matched_measurement.first, value: temp_value }
        end
      end.compact
    end
  end
end
