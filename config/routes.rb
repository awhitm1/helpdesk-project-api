Rails.application.routes.draw do
  get 'sessions/create'
  # User routes
  get '/users' => 'users#index'
  get '/users/:id' => 'users#show'
  post '/users' => 'users#create'
  put '/users/:id' => 'users#update'
  delete '/users/:id' => 'users#destroy'
  get '/users/:id/tickets' => 'users#user_tickets'
  get '/users/:id/assigned_tickets' => 'users#assigned_tickets'
  get '/users_is_tech' => 'users#is_tech'

  # Ticket routes
  get '/tickets' => 'tickets#index'
  get '/tickets/:id' => 'tickets#show'
  get '/tickets/status/:id' => 'tickets#tickets_by_status'
  get '/tickets/location/:id' => 'tickets#tickets_by_location'
  get '/tickets_by_group' => 'tickets#tickets_by_group'
  get '/tickets/category/:id' => 'tickets#tickets_by_category'
  get '/tickets/open' => 'tickets#open'
  get '/tickets_created' => 'tickets#users_tickets'
  get '/assigned_tickets' => 'tickets#assigned_tickets'
  get '/tickets_by_group' => 'tickets#tickets_by_group'
  post '/tickets' => 'tickets#create'
  delete '/tickets/:id' => 'tickets#destroy'
  put '/tickets/:id' => 'tickets#update'

  # Claim ticket route
  get '/claim_ticket/:id' => 'tickets#claim_ticket'

  # config routes
  get '/lists' => 'lists#index'
  post '/config/add_group' => 'lists#add_group'
  post '/config/add_status' => 'lists#add_status'
  post '/config/add_location' => 'lists#add_location'
  post '/config/add_category' => 'lists#add_category'
  delete '/config/del_group/:id' => 'lists#del_group'
  delete '/config/del_status/:id' => 'lists#del_status'
  delete '/config/del_location/:id' => 'lists#del_location'
  delete '/config/del_category/:id' => 'lists#del_category'

  # Session routes
  post '/login' => 'sessions#create'
  
  # resources :users, only: [:create, :index, :show, :update, :destroy]
  # resources :tickets, only: [:create, :update, :destroy, :tickets_by_status, :tickets_by_location, :tickets_by_group, :tickets_by_category]




  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  
  # Defines the root path route ("/")
  # root "posts#index"
end
