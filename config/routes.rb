Rails.application.routes.draw do
  get 'contacts/new'

  get 'contacts/create'

  get 'welcome/index'

  get '/foundblanket' => 'welcome#foundblanket'
  post '/foundblanket' => 'welcome#foundblanketform'

  get '/admin' => 'admins#index'
  get '/admins' => 'admins#dash', as: :brand
  post '/admin' => 'sessions#createAdmin', as: :admins_login
  get '/admins/new' => 'admins#new'
  post '/admins/new' => 'admins#create', as: :admins
  get '/admin/dash' => 'admins#dash',as: :admins_dash
  get '/admins/showall' => 'admins#showall'
  get '/admins/showusers' => 'admins#showusers'
  get '/admins/edituser/:id' => 'admins#showOneUser'
  get '/admins/edituser/:id/edit' => 'admins#editUser'
  patch 'admns/edituser/:id' => 'admins#updateUser', as: :admins_update_user
  get '/admins/:id/edit' => 'admins#edit'
  patch '/admin/:id' => 'admins#update', as: :update_admin
  delete '/admins/:id' => 'admins#destroy'
  get '/logout' => 'sessions#sign_out', as: :sign_out
  get '/dash' => 'users#index', as: :users_dash
  post '/checkregistration' => 'welcome#checkblanketregistration'
  resources :users, :blankets
  get '/signin' => 'sessions#new', as: :signin
  post 'signin/user' => 'sessions#createUser'
  get '/register' => 'users#new', as: :register
  get '/blankets/:id/edituser' => 'blankets#edituser'
  post '/blankets/add' => 'blankets#userCreate'
  get '/user/blankets/:id' => 'blankets#userShow'
  patch '/user/blankets/:id/edit' => 'blankets#userUpdate', as: :user_edit_blanket
  post '/user/blankets/destroy/:id' => 'blankets#unregister'

  post '/returnlabel' => 'welcome#makeMailingLabel'
  # You can have the root of your site routed with "root"
   root 'welcome#index'
   post '/contacts' => 'contact_forms#create'
   post '/checkin' => 'users#checkIn'
   get '/map' => 'users#map', as: :map
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
