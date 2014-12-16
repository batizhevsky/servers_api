Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :racks, only: [:index, :update, :create, :destroy]
  end
end
