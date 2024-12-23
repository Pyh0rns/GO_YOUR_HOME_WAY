Rails.application.routes.draw do
  # devise_for :companies
  # devise_for :users

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :companies, controllers: {
    sessions: 'companies/sessions',
    registrations: 'companies/registrations'
  }

  root to: "pages#home"
  resources :properties do
    resources :documents
    resources :work_actions
    resources :list_items, except: :destroy
    resources :appointments, except: :destroy
    collection do
      get :generate_pdf
    end
  end
  resources :list_items, only: :destroy
  resources :appointments, only: :destroy


  resources :companies, only: [:index, :show] do
    resources :favorites, only: [:create]
  end

  resources :favorites, only: [:destroy]

  get 'dashboard', to: "dashboards#dashboard"
  get 'documents', to: "dashboards#documents"
  get 'actions', to: "dashboards#actions"
  get 'contacts', to: "dashboards#contacts"
  get 'calendar', to: "dashboards#calendar"
  get 'lists', to: "dashboards#lists"
  get 'settings', to: "dashboards#settings"


  get 'dashboard_pro', to: "dashboards#dashboard_pro"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
