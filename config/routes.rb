# frozen_string_literal: true

Rails.application.routes.draw do
  scope :v1 do
    devise_for :users, only: :sessions, skip_helpers: true, format: false
  end

  namespace :v1, defaults: { format: :json }, path: 'v1' do
    resources :locations, only: [:show], param: :country_code
    resources :target_groups, only: [:show], param: :country_code
  end

  authenticate do
    resources :evaluate_target, only: [:create]
  end

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  %w[400 401 403 404 422 500].each do |code|
    match code, to: 'errors#show', code: code, via: :all
  end

  match '*path', to: 'errors#show', code: 404, via: :all
end
