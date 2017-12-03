# frozen_string_literal: true

class ApplicationController < ActionController::API
  include HeaderValidator
  include ApiResponder

  rescue_from ActionController::ParameterMissing do |ex|
    respond_with_error(msg: ex.message, status: 400)
  end

  private

  def respond_with_resource
    yield if block_given?
  rescue Parser::Error
    msg = 'Unable to calculate price, please try again later'
    respond_with_error msg: msg, status: 400
  end
end
