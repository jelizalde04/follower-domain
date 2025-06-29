Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs-getFollowers'
  mount Rswag::Api::Engine => '/api-docs-getaddFollowers'
  namespace :api do
    namespace :v1 do
      resources :followers, only: [:index]
    end
  end
end
