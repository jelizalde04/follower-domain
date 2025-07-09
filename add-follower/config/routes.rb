# frozen_string_literal: true

Rails.application.routes.draw do
  get "health/show"
  mount Rswag::Ui::Engine => '/api-docs-addFollower'
  mount Rswag::Api::Engine => '/api-docs-addFollower'
  get '/health', to: 'health#show' 
  namespace :api do
    namespace :v1 do
      resources :followers, only: [:create]
    end
  end
end
