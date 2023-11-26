Rails.application.routes.draw do

  root to: 'user/homes#top'


  scope module: :user do
    get "/about" => "homes#about"
    get "users/mypage" => "users#show"
    get "users/information/edit" => "users#edit"
    patch "users/information" => "users#update"
    get "users/check" => "users#check"
    patch "users/withdraw" => "users#withdraw"
    get 'search' => 'posts#search'
    resources :users do
      member do
        get 'liked_posts'
      end
    end


    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      # resource :like, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      member do
        post 'like'
        delete 'unlike'
      end
    end
  end

  # 顧客用
    # URL /customers/sign_in ...
    devise_for :users, skip: [:passwords], controllers: {
      registrations: "user/registrations",
      sessions: 'user/sessions'
    }


  # # Set the root to your desired path after sign in
  #   devise_scope :user do
  #     authenticated :user do
  #       root 'user/homes#top', as: :authenticated_root
  #     end

  #     unauthenticated do
  #       root 'user/homes#top', as: :unauthenticated_root
  #     end


    # end






  namespace :admin do
    get '/' => 'homes#top'
    resources :comments, only: [:edit, :update]
    resources :users, only: [:edit, :update, :index, :show]
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
