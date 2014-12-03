Rails.application.routes.draw do
  resources :equipos

  resources :participante_competencia

  resources :rol_tecnicos

  resources :tecnicos

  resources :jugadors

  resources :encuentros

  resources :recintos

  resources :organizadors

  get 'nueva_competencia/paso1'
  post 'nueva_competencia/paso1'

  get 'nueva_competencia/paso2'
  post 'nueva_competencia/paso2'

  get 'nueva_competencia/paso3'
  post 'nueva_competencia/paso3'

  get 'nueva_competencia/paso4'
  post 'nueva_competencia/paso4'

  get 'nueva_competencia/paso5'
  post 'nueva_competencia/paso5'

  get 'nueva_competencia/paso6'
  post 'nueva_competencia/paso6'

  get 'nueva_competencia/paso7'
  post 'nueva_competencia/paso7'

  get 'nueva_competencia/paso8'
  post 'nueva_competencia/paso8'

  get 'nueva_competencia/paso9'
  post 'nueva_competencia/paso9'

  get 'home/index'

  root :to => 'home#index'
  devise_for :users
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
