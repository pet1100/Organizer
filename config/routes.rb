class NotLoggedIn
  def matches?(request)
    !request.session[:user_id]
  end
end

class IsLoggedIn
  def matches?(request)
    request.session[:user_id]
  end
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root :to => 'sessions#new', constraints: NotLoggedIn.new
  post 'login' => "sessions#create", as: :login, constraints: NotLoggedIn.new
  constraints(IsLoggedIn.new) do
    root :to => 'home#index', as: :home

    post 'logout' => "sessions#destroy", as: :logout
    resources :tasks, only: [:new, :create, :edit, :update, :destroy]
    patch 'toggle/:id/task' => "tasks#toggle"
    namespace :snapshots do
        get :export
        post :import
        get :show
    end

  end
end
