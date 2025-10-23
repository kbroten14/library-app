Rails.application.routes.draw do
  root 'users#index'
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  
  resources :users do
    collection do
      get :list, :customer
    end
  end
  
  resources :books do
    collection do
      get :list, :export
      post :returned, :import, :checkout
    end
  end
end
