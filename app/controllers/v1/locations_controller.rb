# frozen_string_literal: true

module V1
  class LocationsController < ::ApplicationController
    before_action :validate_params
    before_action :fetch_country

    def show
      respond_with @country
    rescue Parser::Error
      msg = 'Unable to calculate price, please try again later'
      respond_with_error msg: msg, status: 400
    end

    private

      def validate_params
        if CountryCodeValidation.call(content: params[:country_code]).failure?
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
