Ganaderia::Application.routes.draw do

  get "reports/inventario_mensual"

  get "home/index"

  get "gestions/abrir/:id" => "gestions#abrir"
  get "gestions/cerrar/:id" => "gestions#cerrar"
  post "gestions/crear_anterior" => "gestions#crear_anterior"

  resources :users
  resources :movimientos
  resources :gestions
  resources :movimientos_tipos

  get "ingreso-egreso/new" => "movimientos#new", :type => "in_eg"
  get "movimiento/new" => "movimientos#new", :type => "mov"
  get "recuento/new" => "movimientos#new", :type => "rec"

  get "ingreso-egreso/list" => "movimientos#index", :type => "in_eg"
  get "movimiento/list" => "movimientos#index", :type => "mov"
  get "recuento/list" => "movimientos#index", :type => "rec"

  get "/login" => "users#login"
  post "/login" => "users#do_login"
  get "/logout" => "users#logout"

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
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
