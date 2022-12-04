Rails.application.routes.draw do
  root to: "home#top"
  get '/home/about' => 'home#about',as:'about'
  get 'search' => 'searches#search'
  devise_for :users
  # ネストさせる
  resources :users, only:[:show,:edit,:index,:update] do
    resource :relationships, only:[:create,:destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  # どの本をいいねしたのか判別するため、ネスト
  resources :books, only:[:new,:create,:show,:index,:destroy,:edit,:update] do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
