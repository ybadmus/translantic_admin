# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  resources :incoterms, only: %i[index]
  resources :shipments do
    member do
      get :itenary
      get :pdf
    end
  end

  resources :audits, only: %i[destroy]
  resources :quotes do
    member do
      get :pdf
    end
  end
  resources :locations, except: %i[show]
  resources :customers
  resources :dashboard, only: %i[index]
  get 'dashboard/index'
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :shipments do
        collection do
          post :verify
          get :send_pdf_email
          get :preview_pdf
        end
      end
      resources :quotes, only: %i[create]
      resources :enquiries, only: %i[create]
      resources :incoterms, only: %i[index]
    end
  end

  # Defines the root path route ("/")
  root to: 'dashboard#index'
end
