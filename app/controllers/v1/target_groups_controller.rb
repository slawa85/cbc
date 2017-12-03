# frozen_string_literal: true

module V1
  class TargetGroupsController < ::ApplicationController
    before_action :validate_params, except: :evaluate
    before_action :fetch_country, except: :evaluate
    before_action :validate_evaluation_params, only: :evaluate


    def index
      respond_with_resource do
        respond_with @country, api_template: :v1_target_groups
      end
    end

    def show
      respond_with_resource do
        respond_with @country, api_template: :v1_target_groups
      end
    end

    def evaluate
      respond_with_resource do
        group = TargetGroup.find_by_id!(params[:target_group][:target_group_id])

        # https://github.com/rails/rails/issues/8422#issuecomment-11043573
        respond_with group, api_template: :v1_panel_provider, location: nil
      end
    rescue ActiveRecord::RecordNotFound => e
        fail ActionController::ParameterMissing.new(e)
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

      def validate_evaluation_params
        validation = TargetGroupEvaluationValidator.call(params: params[:target_group])
        if validation.failure?
          respond_with_error(msg: validation.messages, status: 400)
        end
      end
  end
end
