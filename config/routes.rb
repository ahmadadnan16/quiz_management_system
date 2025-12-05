Rails.application.routes.draw do
  # Admin routes
  namespace :admin do
    resources :quizzes do
      resources :questions do
        resources :options
      end
    end
  end

  # Public routes
  root 'quizzes#index'
  get '/quizzes/:slug', to: 'quizzes#show', as: 'quiz'
  post '/quizzes/:slug/submit', to: 'submissions#create', as: 'submit_quiz'
  get '/quizzes/:slug/results/:submission_id', to: 'submissions#show', as: 'quiz_results'

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
