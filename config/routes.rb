TickeTouch::Application.routes.draw do
  
  root :to => "home#index"

  get "session/login"
  post "session/login"

  get "session/logout"

  get "session/index"

  resources :purchases, :only => [:index, :show]

  resources :artists

  match "store/save_purchase" => "store#save_purchase"
  match "store/checkout" => "store#checkout"
  match "store/confirm" => "store#confirm"
  match "store/add_to_cart" => "store#add_to_cart"
  match "store/empty_cart" => "store#empty_cart"
  match "store/remove_from_cart" => "store#remove_from_cart"
  match "store/show_cart" => "store#show_cart"
  match "session/forbidden" => "session#forbidden"
  match "events/search" => "events#search"
  match "events/add_artist" => "events#add_artist"
  match "events/remove_artist" => "events#remove_artist"
  
  resources :events do
    resources :stages do
      resources :ticket_types
    end
  end

  resources :sites

  resources :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
