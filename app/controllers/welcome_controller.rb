class WelcomeController < ActionController::API
  def index
    render html: 'Please refer to `/v1`'
  end
end
