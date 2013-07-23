PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/login',     to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  get '/logout',   to: "sessions#destroy"

  get '/register',   to: 'users#new'

  # con: redundant logic,
  # pro: no new resource, don't have to pass in type or id
  resources :posts, except: [:delete] do
    member do
      post 'vote'
      # POST "/posts/2/vote"
    end
    resources :comments, only: [:create] do
      member do
        post 'vote'
        # POST "/posts/2/comments/3/vote"
      end
    end
  end


  resources :categories , only:[:new, :create, :show]

  resources :users, only: [:show, :create, :edit, :update]
end
