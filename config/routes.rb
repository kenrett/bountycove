Daddyshop::Application.routes.draw do

  resources :captains, :except => :index do
    resources :treasures
    resources :tasks
    resources :pirates, :except => :show
  end

  resources :pirates, :only => :show do
    resources :treasures, :only => :index
  end

  root :to => "pages#index"

  post "/login" => "session#login"
  post "/logout" => "session#logout"

  # Pirates
  post "/pirates/:pirate_id/treasures/:treasure_id/buys" => "pirates#buys", :as => 'pirate_buys'
end
