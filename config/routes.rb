Rails.application.routes.draw do
  resources :drivers, only: [:create, :update, :show, :destroy] do
    resources :metrics
  end
  resources :metrics
  root to: 'welcome#main'
end
