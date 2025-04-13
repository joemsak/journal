Rails.application.routes.draw do
  resources :entries, except: %i[index create destroy], param: :entry_date do
    resources :task_forms, only: %i[create]
  end

  patch :tasks, to: "tasks#update"

  resources :sessions, only: %i[new create]

  get :login, to: "sessions#new"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "entries#new"
end
