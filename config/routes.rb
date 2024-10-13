Rails.application.routes.draw do

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: "home#index"
  resources :users
  resources :image_posts
  resources :music_posts
  resources :match_posts

  # タグの検索で使用する
  get "search_tag" => "home#search_tag"
  # 一覧表示
  get 'feed', to: 'home#feed'

  #いいね機能
  resources :image_posts do
    resources :likes, only: [:create, :destroy]
  end

  resources :music_posts do
    resources :likes, only: [:create, :destroy]
  end

  resources :match_posts do
    resources :likes, only: [:create, :destroy, :new_candidates]
  end

  resources :users do
    member do
      get :show_following
    end
  end
  resources :relationships, only: [:create, :destroy]

end
