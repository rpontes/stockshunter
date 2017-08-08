Rails.application.routes.draw do
  root 'dashboard#index'

  resources :quotations, only: :index
end
