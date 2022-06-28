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
  root :to => 'sessions#new'
  post 'login' => "sessions#create", as: :login, constraints: NotLoggedIn.new
  constraints(IsLoggedIn.new) do
    post 'logout' => "sessions#destroy", as: :logout
    get 'home' => 'home#index', as: :home
  end
end
