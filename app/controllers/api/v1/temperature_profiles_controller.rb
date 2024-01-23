# frozen_string_literal: true

class Api::V1::TemperatureProfilesController < ApplicationController
  def index
    search_query = TemperatureProfile.ransack(params[:q])
    temperature_profiles = search_query.result.page(params[:page]).per(params[:per_page])

    render json: temperature_profiles, each_serializer: Api::V1::TemperatureProfiles::Serializer
  end
end
