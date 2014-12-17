Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :racks, only: [:index, :show, :update, :create, :destroy]
    resources :hosts, only: [:index, :show, :update, :create, :destroy]
  end
end
