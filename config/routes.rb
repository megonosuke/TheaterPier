Rails.application.routes.draw do
  
  root to: 'user/homes#top'
  
  scope module: :user do
    get "/about" => "homes#about"
    get "users/mypage" => "users#show"
    get "users/information/edit" => "users#edit"
    patch "users/information" => "users#update"
    get "users/check" => "users#check"
    patch "users/withdraw" => "users#withdraw"
    #get '/genre/search' => 'searches#genre_search'
    resources :comments, only: [:edit, :update]
    resources :likes, only: [:index]
    # resources :users, only: [:edit, :update, :index, :show]
    resources :posts, only: [:new, :create, :index, :show, :edit, :update]
  end

  namespace :admin do
    get '/' => 'homes#top'
    resources :comments, only: [:edit, :update]
    resources :users, only: [:edit, :update, :index, :show]
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
