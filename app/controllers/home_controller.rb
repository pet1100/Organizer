class HomeController < ApplicationController
  def index
  end

  def current_user
    User.find(session[:user_id])
  end
  helper_method :current_user

  def tasks
    User.find(session[:user_id]).tasks
  end
  helper_method :tasks
end
