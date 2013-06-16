Daddyshop::Application.routes.draw do

  resources :captains, :except => :index do
    resources :treasures
    resources :tasks
    resources :pirates, :except => :show
  end

  resources :pirates, :only => :show do
    resources :treasures, :only => :index
    resources :tasks, :only => [:index, :show]
  end

  root :to => "pages#index"

  post "/login" => "session#login"
  post "/logout" => "session#logout"

end
