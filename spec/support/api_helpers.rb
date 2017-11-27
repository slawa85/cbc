# frozen_string_literal: true

def as_api(resource, api_template = :"v1_default")
  hash = resource.as_api_response(api_template)
  # Originally dates are objects in as_api_response, so comparision fails
  JSON.parse(hash.to_json, symbolize_names: true)
end

def debug_response
  puts "Status: #{response.status}"
  puts response.body
end

def result
  JSON.parse(response.body).with_indifferent_access
end

def auth_for(user)
  @auth_header = { Authorization: "Bearer #{Warden::JWTAuth::UserEncoder.new.call(user, :user)}" }
end

def with_auth(expect_200: true, expect_401: true)
  yield({})
  if expect_401
    expect_status(401)
    expect_json('error.message', 'You need to sign in or sign up before continuing.')
  end

  yield({ headers: @auth_header })
  if expect_200
    if response.status != 200
      debug_response
    end

    expect_status(200)
  end
end

def expect_json_scheme(path, scheme)
  expect_json_types(path, scheme)
  expect_json_keys(path, scheme.keys)
end

