# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  resources :incoterms, only: %i[index]
  resources :shipments
  resources :quotes
  resources :locations, except: %i[show]
  resources :customers
  get 'dashboard/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'dashboard#index'
end
