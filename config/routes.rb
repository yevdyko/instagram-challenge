Rails.application.routes.draw do
  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }
  
  root 'posts#index'
  
  get ':username', to: 'profiles#show', as: :profile

  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end
end
