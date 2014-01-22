class HomeController < ApplicationController
  protect_from_forgery with: :exception, except: [:frontend_error, :logoff]

  def index
  end
end
