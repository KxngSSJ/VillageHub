Rails.application.routes.draw do
  get "home/index"
  # the Home page
  root "home#index"

  # Signup routes (Create new user account)
  get "signup", to: "users#new"     # Show signup form
  post "signup", to: "users#create" # Handle signup form submission

  # Login and logout routes
  get "login", to: "sessions#new"    # Shows the login form
  post "login", to: "sessions#create" # Handles the login form submission
  delete "logout", to: "sessions#destroy" # for logging out

  # Forgot password route
  get  "password/forgot",  to: "passwords#forgot"
  post "password/reset",   to: "passwords#reset"

   # Admin user route
   get "admin/dashboard", to: "admin#dashboard"

   # About Us route
   get "about", to: "pages#about"


  # Users routes (only show action for now)
  resources :users, only: [ :show, :edit, :update ]  # Add edit & update actions

  # Work post routes with nested ratings
  resources :work_posts do
     resources :ratings, only: [ :create ] # allow users to rate a specific work post
  end
end
