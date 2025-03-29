Rails.application.routes.draw do
  get "shared_lists/create"
  get "shared_lists/destroy"
  get "shared_lists/update"
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :todo_lists do
    resources :tasks do
      member do
        patch :toggle_status  # This creates the route for toggling status
      end
    end
    resources :shared_lists, only: [:create, :update, :destroy]
  end
  get "home/index"
  root 'home#index'
end
