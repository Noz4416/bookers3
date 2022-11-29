Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  root to: "home#top"
  get '/home/about' => 'home#about',as:'about'
  devise_for :users
  # ネストさせる
  resources :users, only:[:show,:edit,:index,:update] do
    resource :relationships, only:[:create,:destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :books, only:[:new,:create,:show,:index,:destroy,:edit,:update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
