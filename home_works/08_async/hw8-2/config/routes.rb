Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount GrapeApi => '/api'
  mount GrapeSwaggerRails::Engine => '/swagger'
  
  get 'groups/calc', to: 'groups#calc'

  resources :groups

  resources :vms

  namespace :admin do
    resources :orders
  end
  
  get '/', to: 'orders#calc'

  get 'orders/calc', to: 'orders#calc'
  
  resource :login, only: [:show, :create, :destroy]

  resources :orders do
    collection do
      get 'first'
    end
  end

  resources :users

  get 'hello/index'

  resources :orders do
    member do
      get 'approve'
    end
  end

end
