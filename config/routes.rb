Rails.application.routes.draw do
  namespace :user do
    get 'comments/edit'
  end
  namespace :user do
    get 'likes/index'
  end
  namespace :user do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :user do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :admin do
    get '/' => 'homes#top'
  end
  namespace :user do
    root to: 'user/homes#top'
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
