Daddyshop::Application.routes.draw do

  resources :captains, :except => :index do
    resources :treasures
    resources :tasks
    resources :pirates
  end

  resources :pirates, :only => :show do
    resources :treasures
    resources :tasks, :only => [:index, :show]
  end

  root :to => "pages#index"

  post "/login" => "session#login"
  post "/logout" => "session#logout"

  # Pirate buys treasure
  post "/pirates/:pirate_id/treasures/:treasure_id/buys_treasure" => "pirates#buys_treasure", :as => "pirate_buys_treasure"

  # Pirate add task
  get "/pirates/:pirate_id/tasks/:task_id/adds" => "pirates#adds", :as => "pirate_adds"

  # Pirate Complete task
  get "/pirates/:pirate_id/tasks/:task_id/completes" => "pirates#completes", :as => "pirate_completes"

  # Captain Confirm Task Complete
  get "/captains/:captain_id/tasks/:task_id/confirm" => "captains#confirm", :as => "captain_confirms"

  # Captain delivers treasure
  post "/captains/:captain_id/treasures/:treasure_id/delivers_treasure" => "captains#delivers_treasure", :as => 'captain_delivers_treasure'

  # Captain edit pirate's account
  get '/captains/:captain_id/pirates/:pirate_id/edits_pirate_acct' => 'captains#edits_pirate_acct', :as => 'captain_edits_pirates_acct'
end
