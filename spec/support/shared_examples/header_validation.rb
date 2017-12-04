# frozen_string_literal: true

shared_examples 'Header Validation' do
  describe 'wrong headers' do
    it 'fail with malformed Accept header' do
      get '/v1/locations/DE', {}, {'Accept' => 'marformed'}

      expect_status(400)
      expect_json_types('error', message: :string)
    end
  end

  describe 'valid headers' do
    it 'succeed' do
      get '/v1/locations/DE', {}, {'Accept' => 'application/vnd.api.v1+json'}

      expect_status(200)
    end
  end
end
