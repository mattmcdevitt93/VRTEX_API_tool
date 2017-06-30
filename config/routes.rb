Rails.application.routes.draw do

  
  resources :blacklists
  resources :posts
    resources :topics
    resources :memberships
    resources :groups
    get 'users/new'

    get 'users/create'
    devise_for :users, :controllers => {:registrations=> "registrations"}
    resources :users
    resources :timesheets
    resources :contacts
    resources :srp_requests
    resources :groups
    resources :memberships
    root 'users#dashboard'
    get '/index' => 'users#index'
    get '/stats' => 'users#stats'

    
    get '/log_index' => 'toolbox#log_index'
    get '/log_index_events' => 'toolbox#log_index_events'
    get '/log_file' => 'toolbox#log_file'
    get '/dev_notes' => 'toolbox#dev_notes'
    get '/admin_dashboard' => 'toolbox#admin_dashboard'
    get '/char_sheet' => 'toolbox#char_sheet'
    get '/recent_topics' => 'topics#recent_topics'

    get '/admin_index' => 'srp_requests#admin_index'
    get '/admin_index_pending' => 'srp_requests#admin_index_pending'
    get '/admin_index_all' => 'srp_requests#admin_index_all'
    get '/admin_index_flagged' => 'srp_requests#admin_index_flagged'

    get '/full_index' => 'memberships#full_index'





    # resources :log
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
