Hellokik::Application.routes.draw do
  root to: 'home#index'

  namespace :api do
    resources :users, defaults: { format: :json }, only: [:create, :index]
  end


  # This will ensure we meet Kik's caching standards
  offline = Rack::Offline.configure cache_interval: 1.week do
    Dir[Rails.root.join('app','assets', 'images', '**', '*')].sort.each do |full_path|
      path = full_path.split('app/assets/images/').last
      cache ActionController::Base.helpers.asset_path(path)
    end
    cache ActionController::Base.helpers.asset_path("application.css")
    cache ActionController::Base.helpers.asset_path("application.js")

    # cache other assets
    network "*"
  end
  get "/manifest.appcache" => offline
end
