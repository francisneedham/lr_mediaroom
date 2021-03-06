LrMediaroom::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

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
  get '/ricerca' => 'photos#search', :as => 'search'
  get '/accedi' => 'sessions#new', :as => 'new_session'
  post '/accedi' => 'sessions#create', :as => 'create_session'
  get  '/esci' => 'sessions#destroy', :as => 'destroy_session'
  resources :videos, :only => [:index] do
    member do
      get '/download' => 'videos#download', :as => 'download_attachment'
    end
  end
  resources :galleries, :only => :index do
    resources :photos, :only => [:index, :show] do
      get 'download-originale' => 'photos#download', :on => :member, :as => 'download'
    end
  end
  root :to => 'galleries#index'
  match "/signup" => redirect("http://eepurl.com/kvmXv"), :as => :signup
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end