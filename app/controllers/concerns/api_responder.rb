# frozen_string_literal: true

module ApiResponder
  include ActsAsApi::Rendering
  include ApiResponseFormatter

  def self.included(base)
    base.respond_to :json
    base.responder = ActsAsApi::Rendering
  end

  private

  def respond_with(resource, opts = {})
    if resource.is_a?(ActiveRecord::Base) && !resource.valid?
      msg = resource.errors.messages.first.flatten.map(&:to_s).join(' ').humanize
      respond_with_error msg: msg, status: 422 and return
    else
      set_headers
      opts[:api_template] ||= :v1_default
      super(resource, opts)
    end
  end

  def respond_with_success
    set_headers

    render json: success_response_body
  end

  def respond_with_error(msg: nil, status: 500)
    set_headers

    render json: error_response_body(msg, status.to_i), status: status.to_s
  end
end
