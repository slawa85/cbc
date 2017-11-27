class WelcomeController < ::ApplicationController
  def index
    render html: 'Please refer to `/v1`'
  end
end
