Rails.application.routes.draw do
  root to: "events#index"

  resources :events
  resources :users, only: %i[edit show update]
end
