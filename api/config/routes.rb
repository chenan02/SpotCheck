Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'application#index'
    resources :places
    resources :devices
    resources :users do
        resources :favorites
    end
    resources :sessions
    get '/signup', to: 'users#new'
    get '/login', to: 'sessions#new'
    match '/logout', to: 'sessions#destroy', via: :delete 
end
