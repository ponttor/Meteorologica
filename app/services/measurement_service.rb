# frozen_string_literal: true

class MeasurementService
  class << self
    def get_measurement_attributes(measurement_params)
      measurement_params.map { |param| { date: param[:date] } }
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

    def import_measurements(measurement_attributes, measurements_params)
      ActiveRecord::Base.transaction do
        imported_measurements = Measurement.import(measurement_attributes, returning: [:id, :date])      
        temperature_attributes = MeasurementService.get_temperature_attributes(measurements_params, imported_measurements)
  
        Temperature.import(temperature_attributes)
      end
    end
  end
end
