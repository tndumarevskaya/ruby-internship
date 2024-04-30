Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount GrapeApi => '/api'
  mount Sidekiq::Web => '/sidekiq'

  resources :reports
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
