Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'job_search#index'

  resources :job_search, only: %i[create]
end
