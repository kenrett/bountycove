Daddyshop::Application.routes.draw do

  resources :users, :except => :index
  root :to => "pages#index"
  post "/user/logout" => "users#logout"

end
