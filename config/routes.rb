ProyectoVida::Application.routes.draw do

  resources :pago_cuota

  resources :liquidacion_comisions

  resources :nota_devolucions

  resources :nota_entregas

  resources :entrada_inventarios

  resources :coordinadors

  resources :asesors

  resources :moderadors

  resources :director_comercials

  resources :gerente_comercials

  resources :cuota

  resources :producto_ingresos

  resources :producto_pedidos

  resources :transitos

  resources :inventarios

  resources :productos

  resources :pedidos

  resources :permisos

  resources :permisos_por_rols

  resources :rols

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "usuarios#new", :as => "sign_up"
  root :to => "sessions#new"
  resources :usuarios
  resources :sessions

  get "sessions/new"

  get "usuarios/new"

  get "ventas" => "ventas#index", :as => "ventas"
  get "buscador" => "buscador#index", :as => "buscador"


  post "buscar" => "pedidos#buscar", :as => "buscar"
  post "buscartransito" => "transitos#buscartransito", :as => "buscartransito"
  
  get "repartir" => "repartir#index", :as => "repartir"
  post "reparticion" => "repartir#reparticion", :as => "reparticion"
  get "coutas_repartidas" => "repartir#coutas_repartidas", :as => "coutas_repartidas"

  post "buscar_cuotas" => "repartir#buscar_cuotas", :as => "buscar_cuotas"

  post "buscar_cuotas_index" => "cuota#buscar_cuotas_index", :as => "buscar_cuotas_index"

	#Liquidaciones
  post "buscar_liquidacion_asesor" => "liquidacion_comisions#buscar_liquidacion_asesor", :as => "buscar_liquidacion_asesor"
  post "buscar_liquidacion_moderador" => "liquidacion_comisions#buscar_liquidacion_moderador", :as => "buscar_liquidacion_moderador"
  post "buscar_liquidacion_coordinador" => "liquidacion_comisions#buscar_liquidacion_coordinador", :as => "buscar_liquidacion_coordinador"
  post "buscar_liquidacion_director_comercial" => "liquidacion_comisions#buscar_liquidacion_director_comercial", :as => "buscar_liquidacion_director_comercial"
  post "buscar_liquidacion_gerente_comercial" => "liquidacion_comisions#buscar_liquidacion_gerente_comercial", :as => "buscar_liquidacion_gerente_comercial"

  get "liquidacion_moderador" => "liquidacion_comisions#liquidacion_moderador", :as => "liquidacion_moderador"

  get "liquidacion_coordinador" => "liquidacion_comisions#liquidacion_coordinador", :as => "liquidacion_coordinador"

  get "liquidacion_director_comercial" => "liquidacion_comisions#liquidacion_director_comercial", :as => "liquidacion_director_comercial"

  get "liquidacion_gerente_comercial" => "liquidacion_comisions#liquidacion_gerente_comercial", :as => "liquidacion_gerente_comercial"

  #match 'cuotum/:id/marcar' => 'Cuotum#marcar', :as => :marcar

  get "marcar" => "cuota#marcar", :as => "marcar"

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
  # match ':controller(/:action(/:id))(.:format)'
end
