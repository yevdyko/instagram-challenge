Rails.application.routes.draw do
  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through
  get 'notifications', to: 'notifications#index'

  get 'profiles/show'

  devise_for :users, controllers: {
                       registrations:      'users/registrations',
                       sessions:           'users/sessions',
                       omniauth_callbacks: 'users/omniauth_callbacks'
                     },
                     path_names: {
                       sign_in:  'login',
                       sign_up:  'signup',
                       sign_out: 'logout'
                     }

  devise_scope :user do
    get 'users/auth/failure', to: 'users/omniauth_callbacks#failure',
                              as: :omniauth_failure
  end

  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root to: redirect('/users/signup')

  get 'browse', to: 'posts#browse', as: :browse_posts

  get   ':username',      to: 'profiles#show',   as: :profile
  get   ':username/edit', to: 'profiles#edit',   as: :edit_profile
  patch ':username/edit', to: 'profiles#update', as: :update_profile

  post ':username/follow_user',   to: 'relationships#follow_user',
                                  as: :follow_user
  post ':username/unfollow_user', to: 'relationships#unfollow_user',
                                  as: :unfollow_user

  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end
end
