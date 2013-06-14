Daddyshop::Application.routes.draw do

  resources :captains, :except => :index
  root :to => "pages#index"

  post "/login" => "session#login"
  post "/logout" => "session#logout"

end
