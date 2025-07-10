# frozen_string_literal: true

Rails.application.routes.draw do
  get '/health', to: proc { [200, { 'Content-Type' => 'application/json' }, ['{"status":"ok"}']] }
  mount Rswag::Ui::Engine => '/api-docs-removeFollower'
  mount Rswag::Api::Engine => '/api-docs-removeFollower'
  
  namespace :api do
    namespace :v1 do
      delete '/followers', to: 'followers#destroy'
    end
  end
end
