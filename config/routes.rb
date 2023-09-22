Rails.application.routes.draw do

  resources :categories do
    resources :entities
  end
  
  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy'
  end
  
  devise_for :users
  root "home#index"
end
