# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :agents do
    collection do
      post :import
      get :export  # Ajoutez la route pour l'exportation
      get :importation
    end
  end
  resources :directions
  resources :contrats
  resources :maisons, only: [:index]
  root "agents#index"
end
