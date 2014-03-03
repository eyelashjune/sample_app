SampleApp::Application.routes.draw do
  #We can get the REST-style URL to work by adding a single line to our routes file 
  # resources :users doesn’t just add a working /users/1 URL;
  #it endows our sample application with all the actions needed for a RESTful Users resource,5 along with a large number of named routes (Section 5.3.3) for generating user URLs.
  #The resulting correspondence of URLs, actions, and named routes is shown in Table 7.1. (Compare to Table 2.2.) Over the course of the next three chapters, we’ll cover all of the other entries in Table 7.1 as we fill in all the actions necessary to make Users a fully RESTful resource.
  resources :users

  #To get the tests in Listing 8.1 to pass, we first need to define routes for the Sessions resource, together with a custom named route for the signin page (which we’ll map to the Session controller’s new action). As with the Users resource, we can use the resources method to define the standard RESTful routes:
  #Since we have no need to show or edit sessions, we’ve restricted the actions to new, create, and destroy using the :only option accepted by resources.
  #Note that the routes for signin and signout are custom, but the route for creating a session is simply the default (i.e., [resource name]_path).
  resources :sessions, only: [:new, :create, :destroy]

  root  'static_pages#home'

  match '/signup',  to: 'users#new',            via: 'get'

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'


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
