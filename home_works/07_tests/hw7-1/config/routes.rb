Rails.application.routes.draw do
  get 'orders/check', to: 'orders#check'

  namespace :admin do
    root 'welcome#index'
  end
  namespace :admin do
    resources :welcomes
  end
  get 'welcome/main'
  namespace :admin do
    resources :orders
  end
  root 'orders#calc'

  resources :users

  get 'hello/index'
  
  resources :orders do
    member do
      get 'approve'
    end

    collection do
      get 'first'
    end
  end

  resource :login, only: [:show, :create, :destroy]

  

end
