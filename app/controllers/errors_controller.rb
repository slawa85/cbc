class ErrorsController < ::ApplicationController
  include ApiResponder

  def show
    e = request.env['action_dispatch.exception']

    msg = if e.present?
      if Rails.env.production?
        '<Message hidden>'
      else
        "#{e.inspect} @ #{e.backtrace[0]}"
      end
    else
      nil
    end

    respond_with_error(msg: msg, status: params[:code])
  end
end
