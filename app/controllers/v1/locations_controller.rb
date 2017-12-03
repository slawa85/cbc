# frozen_string_literal: true

module V1
  class LocationsController < ::ApplicationController
    before_action :validate_params
    before_action :fetch_country

    def index
      respond_with_resource do
        respond_with @country
      end
    end

    def show
      respond_with_resource do
        respond_with @country
      end
    end

    private

      def validate_params
        if CountryCodeValidator.call(content: params[:country_code]).failure?
          message = "#{params[:country_code]} wrong param format only valid country code allowed"
          fail ActionController::ParameterMissing.new(message)
        end
      end

      def fetch_country
        @country ||= Country.find_by_code!(params[:country_code])
      rescue ActiveRecord::RecordNotFound => e
        fail ActionController::ParameterMissing.new(e)
      end
  end
end
