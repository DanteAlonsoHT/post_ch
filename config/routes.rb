Rails.application.routes.draw do
  scope "(:locale)", locale: /en|es/ do
      # Rutas para Devise (autenticación)
      devise_for :users

      # Definimos las rutas para la API de posts
      namespace :api do
        resources :posts, only: [:index, :create, :show, :update, :destroy]
      end

      # Página principal para ver todos los posts
      root 'posts#index'

      # Rutas para gestionar la creación y edición de posts desde el frontend
      resources :posts, only: [:index, :new, :show, :edit]

      # Definir rutas para autenticación manual (login/logout)
      get '/login', to: 'sessions#new'
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
  end
end
