Daddyshop::Application.routes.draw do

  resources :users, :except => :index
  root :to => "pages#index"

  get "/login" => "session#login"
  get "/logout" => "session#logout"

end
