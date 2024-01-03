Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # post '/api/v1/otp/generate' => "otps#generate", as: :generate_otp
  # post '/api/v1/otp/verify' => "otps#verify", as: :verify_otp

  namespace :api do
    namespace :v1 do
      resource :otps, only: [] do
        post :generate
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
