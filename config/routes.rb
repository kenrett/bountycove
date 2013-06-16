Daddyshop::Application.routes.draw do

  resources :captains, :except => :index do
    resources :treasures
    resources :tasks
    resources :pirates, :except => :show
  end

  resources :pirates, :only => :show do
    resources :treasures
    resources :tasks, :only => [:index, :show]
  end

  root :to => "pages#index"

  post "/login" => "session#login"
  post "/logout" => "session#logout"

  # Pirate buys treasure
  post "/pirates/:pirate_id/treasures/:treasure_id/buys" => "pirates#buys", :as => "pirate_buys"

  # Pirate add task
  post "/pirates/:pirate_id/tasks/:task_id/adds" => "pirates#adds", :as => "pirate_adds"
end
