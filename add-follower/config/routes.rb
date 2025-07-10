# frozen_string_literal: true

Rails.application.routes.draw do
  get '/health', to: proc { [200, { 'Content-Type' => 'application/json' }, ['{"status":"ok"}']] }

  mount Rswag::Ui::Engine => '/api-docs-addFollower'
  mount Rswag::Api::Engine => '/api-docs-addFollower'

  namespace :api do
    namespace :v1 do
      resources :followers, only: [:create]
    end
  end
end
