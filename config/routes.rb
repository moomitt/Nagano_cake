Rails.application.routes.draw do
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :create, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  
  scope module: 'public' do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    
    resources :genres, only: [:show]
    
    resources :items, only: [:index, :show]
    
    get 'customers/mypage' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/withdraw_confirm' => 'customers#confirm'
    patch 'customers/withdraw'
    
    
    delete 'cart_items/destroy_all', as: 'destroy_all_cart_item'
    resources :cart_items, only: [:index, :update, :create, :destroy]
    
    get 'orders/confirm'
    post 'orders/confirm'
    patch 'orders/confirm'
    get 'orders/complete'
    resources :orders, only: [:new, :create, :index, :show]
    
    delete 'addresses/:id' => 'addresses#destroy', as: 'destroy_address'
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
