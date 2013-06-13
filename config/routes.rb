Daddyshop::Application.routes.draw do

  resources :user, :except => :index
  root :to => "pages#index"

end
