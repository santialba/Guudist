Rails.application.routes.draw do
  devise_for :users
  root 'tasks#index'
  resources :users do
    resources :tasks do
      member do
        patch :complete
      end
    end
    resources :tags
  end
end
