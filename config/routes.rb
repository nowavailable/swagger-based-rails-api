Rails.application.routes.draw do
  resources :change_email_requests
  resources :joining_requests, only: [:new, :create, :show] do
    collection do
      get ':id/verify', :controller => 'joining_requests', :action => "verify", :as=>'verify'
    end
  end
  resources :users
  resources :mentors

  namespace :api, {format: "json"} do
    resources :questions, except: [:new]
    resources :answers, only: [:create,:update,:destroy]
    resources :users, only: [:show]
    resources :acknowledgements, only: [:create,:update,:destroy]
    resources :votings, only: [:create]
    resources :notifications, only: [:index]
    resources :moral_hazards, only: [:create]
  end
  namespace "admin" do
    resources :users
    resources :mentors
    resources :questions
    resources :answers
    resources :question_categories
    resources :moral_hazards
  end

  get 'login', to: 'logins#login'
  get 'after_login', to: 'logins#after_login'

  # root 'top#index'
 end
