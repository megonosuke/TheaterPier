Rails.application.routes.draw do

  root to: 'user/posts#index'


  scope module: :user do
    get "/about" => "homes#about"
    get "users/mypage" => "users#show"
    get "users/mypage/edit" => "users#edit"
    patch "users/mypage" => "users#update"
    get "users/check" => "users#check"
    patch "users/withdraw" => "users#withdraw"
    get 'search' => 'posts#search'



    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      member do
        put 'toggle_published', to: 'posts#toggle_published'
      end

      resource :like, only: [:create, :destroy, :index]
      resources :comments, only: [:create, :destroy]
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
    resources :comments, only: [:index, :destroy]
    resources :users, only: [:index,:new,:create,:show,:edit,:update]
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
