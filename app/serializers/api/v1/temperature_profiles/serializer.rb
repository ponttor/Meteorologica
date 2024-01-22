class Api::V1::TemperatureProfiles::Serializer < ActiveModel::Serializer
  attributes :date, :min, :max, :average
end