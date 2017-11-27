# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Locations', type: :request do
  context '/locations/:country_code' do
    describe 'wrong headers' do
      it 'fail with malformed Accept header' do
        with_auth(expect_200: false, expect_401: false) do |args|
          get '/v1/locations/1', args, {'Accept' => 'marformed'}
        end

        expect_status(400)
        expect_json_types('error', message: :string)
      end
    end

    describe '#GET' do
      it 'should return all locations accordingly to country code' do
      end
    end
  end
end
