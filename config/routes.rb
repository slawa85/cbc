# frozen_string_literal: true

Rails.application.routes.draw do
  scope :v1, defaults: { format: :json } do
    devise_for :users, only: :sessions, skip_helpers: true
  end

  namespace :v1, defaults: { format: :json }, path: 'v1' do
    get '/locations/:country_code', to: 'locations#index'
    get '/target_groups/:country_code', to: 'target_groups#index'

    scope :users do
      authenticate do
        resources :locations, only: [:show], param: :country_code
        resources :target_groups, only: [:show], param: :country_code
        post '/evaluate_target', to: 'target_groups#evaluate'
      end
    end
  end

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  %w[400 401 403 404 422 500].each do |code|
    match code, to: 'errors#show', code: code, via: :all
  end

  match '*path', to: 'errors#show', code: 404, via: :all
end
