Rails.application.routes.draw do
  # Default root route to login
  root "sessions#trangchinh"

  # Health check route
  get "up", to: "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  # User registration routes
  get "register", to: "home#register", as: :register
  post "register", to: "home#create", as: :register_create

  # Login and Logout routes
  get "login", to: "sessions#login", as: :login
  post "login", to: "sessions#create"

  get 'trangchinh',to:"sessions#trangchinh", as: 'trangchinh'
  post "trangchinh",to:"sessions#face"

  get"trangchu",to:"home#trangchu",as:"trangchu"
  # config/routes.rb
  get "show",to:"sessions#show",as: 'show'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  # Password recovery routes
  get "laylaimatkhau", to: "home#laylaimatkhau", as: :password_reset_request
  post "laylaimatkhau", to: "home#laylaimatkhau_submit"

  get "quenmatkhau", to: "home#quenmatkhau", as: :password_recovery
  post "quenmatkhau", to: "home#quenmatkhau_submit"

  
  #mailer
  post '/send_verification_code', to: 'password_resets#send_verification_code'
  post '/verify_code', to: 'password_resets#verify_code'
  get 'send_verification_code', to: 'password_resets#send_verification_code'

end
