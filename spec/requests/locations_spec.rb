# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Locations', type: :request do
  before do
    allow_any_instance_of(PanelProvider).to receive(:price).and_return(2.34)
  end

  context '/locations/:country_code' do
    it_should_behave_like 'Header Validation'
    context '#GET' do
      context 'public endpoints' do
        it 'should return locations accordingly to country code' do
          get '/v1/locations/DE', {}, {'Accept' => 'application/vnd.api.v1+json'}

          expect_json_types(country: COUNTRY)
        end
      end

      context 'private endpoints' do
        before do
          @current_user = User.first
          auth_for(@current_user)
        end

        it 'should return locations accordingly to country code' do
          with_auth do |args|
            get '/v1/users/locations/DE', {}, args.merge({'Accept' => 'application/vnd.api.v1+json'})
          end

          expect_json_types(country: COUNTRY)
        end
      end

      context 'invalid params' do
        it 'should fail' do
          get '/v1/locations/1213', {}, {'Accept' => 'application/vnd.api.v1+json'}

          expect_status(400)
          expect_json('error.message', 'param is missing or the value is empty: wrong param format only valid country code allowed')
        end
      end
    end
  end
end
