Ganaderia::Application.routes.draw do

  resources :empleados
  resources :users
  resources :movimientos
  resources :gestions
  resources :movimientos_tipos
  resources :descartes
  resources :cambio_edads
  resources :configuracions
  resources :predios

  get "reports/inventario_predio", as: :reporte_inv_predio
  get "reports/inventario_general", as: :reporte_inv_general

  get "home/index"

  get "gestions/abrir/:id" => "gestions#abrir"
  get "gestions/cerrar/:id" => "gestions#cerrar"
  post "gestions/crear_anterior" => "gestions#crear_anterior"

  get "cambio-edades" => "cambio_edads#index", as: :cambio_edades

  get "ingreso-egreso/new" => "movimientos#new", :type => "in_eg"
  get "movimiento/new" => "movimientos#new", :type => "mov"
  get "recuento/new" => "movimientos#new", :type => "rec"

  get "ingreso-egreso/list" => "movimientos#index", :type => "in_eg"
  get "movimiento/list" => "movimientos#index", :type => "mov"
  get "recuento/list" => "movimientos#index", :type => "rec"

  get "configuracion/cambio-edad" => "configuracions#cambio_edad", as: :config_cambio_edad
  get "configuracion/descartes" => "configuracions#descartes", as: :config_descartes

  get "/login" => "users#login"
  get "/demo" => "users#login", :demo => true
  post "/login" => "users#do_login"
  get "/logout" => "users#logout"

  root :to => "home#index"
end
