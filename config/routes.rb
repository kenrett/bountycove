Daddyshop::Application.routes.draw do

  get "parent_controller/new"

  get "parent_controller/create"

  resources :users, :except => :index do
    resources :items
  end

  root :to => "pages#index"

  get "/login" => "session#login"
  get "/logout" => "session#logout"

end
