class Api::V1::Measurements::Serializer < ActiveModel::Serializer
  attributes :date, :temperatures

  def temperatures
    object.temperatures.pluck(:value)
  end
end