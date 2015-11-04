Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Routes for Courses
  resources :courses, only: [:index, :show] do
    collection do
      get 'get_terms',       to: 'courses#get_terms'
      get 'get_departments', to: 'courses#get_departments'
      get 'get_courses',     to: 'courses#get_courses'
    end
  end


  # Routes for Sessions
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # Routes for Users
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]
  get 'register' => 'users#new'
  resources :users
  resources :users do
    member do
      get 'customize'
    end
  end

  # Routes for Static Pages
  get 'about' => 'static_pages#about'
  get 'terms' => 'static_pages#terms'
  get 'help'  => 'static_pages#help'

  # Home page for logged in Users
  get 'home' => 'home#home'

  # You can have the root of your site routed with "root"
  root 'index#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
