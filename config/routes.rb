Fgrp::Application.routes.draw do
  scope '/admin' do
    devise_for :users
  end

  namespace :admin do
    resources :parks, :except => [:show]
    resources :amenities, :except => [:show]
    resources :users, :except => [:show]
    resources :facts, :except => [:show]
    root :to => "parks#index"
  end

  resources :parks, :only => [:index, :show] 
  root :to => "parks#index"
end
