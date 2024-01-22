class Api::V1::MeasurementsController < ApplicationController
  def create
    measurement_attributes = MeasurementService.get_measurement_attributes(measurements_params)
    return if measurement_attributes.empty?

    begin
      ActiveRecord::Base.transaction do
        imported_measurements = Measurement.import(measurement_attributes, returning: [:id, :date])      
        temperature_attributes = MeasurementService.get_temperature_attributes(measurements_params, imported_measurements)
        Temperature.import(temperature_attributes)
        CalculateTemperatureProfilesJob.perform_later(measurement_attributes.pluck(:date))
      end

      measurement_dates = measurement_attributes.map { |attr| attr[:date] }
      measurements = Measurement.by_date(measurement_dates)
      render json: measurements, each_serializer: Api::V1::Measurements::Serializer

    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
      Rails.logger.error("Measurement creation failed: #{e.message}")
      render json: { error: 'Measurement creation failed' }, status: :unprocessable_entity
    end
  end
  
  private

  def measurements_params
    params.require(:_json).map do |measurement_params|
      measurement_params.permit(:date, measurements: [])
    end
  end
end