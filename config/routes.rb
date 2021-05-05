Rails.application.routes.draw do
  devise_for :users, :controllers=> { registrations: "users/registrations", confirmations: "users/confirmations", sessions: "users/sessions", passwords: "users/passwords"}
  resources :messages
  resources :rooms

  post 'go_live' => 'messages#go_live'
  root 'rooms#index'
end
