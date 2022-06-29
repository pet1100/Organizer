class HomeController < ApplicationController
  def index
  end

  def tasks
    @tasks ||= User.find(session[:user_id]).tasks
  end
  helper_method :tasks
end
