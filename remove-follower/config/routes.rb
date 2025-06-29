# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs-removeFollower'
  mount Rswag::Api::Engine => '/api-docs-removeFollower'
  namespace :api do
    namespace :v1 do
      delete '/followers', to: 'followers#destroy'
    end
  end
end
