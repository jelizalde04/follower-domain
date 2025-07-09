Rails.application.routes.draw do
  get "health/show"
  mount Rswag::Ui::Engine => '/api-docs-getFollowers'
  mount Rswag::Api::Engine => '/api-docs-getaddFollowers'
  get '/health', to: 'health#show'
  namespace :api do
    namespace :v1 do
      resources :followers, only: [:index]
    end
  end
end
