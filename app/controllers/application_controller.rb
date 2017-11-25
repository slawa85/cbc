# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ApiResponder

  before_action :validate_accept_header_format
  before_action :validate_media_type, unless: -> { request.get? }

  rescue_from ActionController::ParameterMissing do |ex|
    respond_with_error(msg: ex.message, status: 400)
  end

  private

  def validate_accept_header_format
    begin
      media_types
    rescue HTTP::Accept::ParseError
      msg = 'Accept header malformed'
      respond_with_error msg: msg, status: 400
    end
  end

  def validate_media_type
    binding.pry
    if request.headers['Content-Type'] != 'application/vnd.api+json'
      msg = "Content-Type header set to 'application/vnd.api+json' required"
      respond_with_error msg: msg, status: 415
    end
  end

  def media_types
    HTTP::Accept::MediaTypes.parse(request.headers.fetch('Accept', ''))
  end
end
