Rails.application.routes.draw do
  resources :drivers, only: [:create, :update, :show, :destroy]
end
