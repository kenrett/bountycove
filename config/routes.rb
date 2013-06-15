Daddyshop::Application.routes.draw do

  resources :captains, :except => :index do
    resources :tasks
  end


  root :to => "pages#index"

  post "/login" => "session#login"
  post "/logout" => "session#logout"

end
