Rails.application.routes.draw do
  devise_for :users

  resources :networks do
    resources :rules
    resources :scheduled_events
    resources :ping_stats, only: [:index, :destroy]
    resources :event_logs
    resources :current_states
    resources :saved_energies
    resources :uptime_stats, only: [:index, :show, :destroy]
    resources :smart_plug_devices
    resources :endpoint_devices
    resources :dashboards, only: [:index]
    resources :switch_lists, only: [:index]
    resources :networks
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "application#choose_network"
end
