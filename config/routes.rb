Socialstock::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  match '/activate_account/:activation_code' => 'activations#create', :as => :activate

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :user_sessions
  resources :users do
    collection do 
      get 'change_password'
      post 'password_update'
      get 'resend_activation'
      post 'resent_activation'
    end
  end
  
  match 'about' => 'users#about', :as => :about
  
  resources :password_resets, :only => [:new, :create, :edit, :update]
  
  resources :friends do 
    collection do
      get 'get_facebook_friends'
      get 'get_facebook_status'
      get 'get_twitter_followers'
      post 'get_contacts'
      get 'user_friends'
    end
  end
    
  resources :authentications  
  match '/auth/:provider/callback' => 'authorizations#create'
  match '/auth/failure' => 'authorizations#failure'
  
  match '/search' => 'search#index', :as => 'search'
  match '/results' => 'search#results', :as => 'results'
  match '/advance_search' => 'search#advance_search', :as => 'advance_search'

  resources :claim_mains do
    member do
      get 'claim_it'  
      get 'email_to_friend'
      get 'send_to_facebook'
    end    
  end
  
  match '/claim_amount' => 'claim_mains#claim', :as => 'claim_amount'
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
  # root :to => "welcome#index"
  root :to => "search#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.  
  # match ':controller(/:action(/:id(.:format)))'
end
