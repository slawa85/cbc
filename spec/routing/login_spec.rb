# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Log in', type: :routing do
  describe 'wrong headers' do
    it 'routes /widgets to the widgets controller' do
      headers = { "CONTENT_TYPE" => "application/html" }
      post '/v1/users/sign_in', params: { email: 'demo1@demo.com', password: 'asd' }, headers: headers

      expect(response).to have_http_status(415)
    end
  end
end
