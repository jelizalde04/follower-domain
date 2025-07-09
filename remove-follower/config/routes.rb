# frozen_string_literal: true

Rails.application.routes.draw do
  get "health/show"
  mount Rswag::Ui::Engine => '/api-docs-removeFollower'
  mount Rswag::Api::Engine => '/api-docs-removeFollower'
  get '/health', to: 'health#show'
  namespace :api do
    namespace :v1 do
      delete '/followers', to: 'followers#destroy'
    end
  end
end
