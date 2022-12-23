Rails.application.routes.draw do
  resources :rules
  resources :scheduled_events
  resources :ping_stats
  resources :event_logs
  resources :current_states
  resources :saved_energies
  resources :uptime_stats
  resources :smart_plug_devices
  resources :endpoint_devices
  resources :networks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#index"
end
