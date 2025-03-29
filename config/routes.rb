Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :todo_lists do
    resources :tasks do
      member do
        patch :toggle_status  # This creates the route for toggling status
      end
    end
  end
  get "home/index"
  root 'home#index'
end
