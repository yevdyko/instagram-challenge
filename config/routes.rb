Rails.application.routes.draw do
  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through
  get 'notifications', to: 'notifications#index'

  get 'profiles/show'

  devise_for :users, controllers: { registrations: 'registrations',
                                    sessions: 'sessions' }

  root 'posts#index'

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
