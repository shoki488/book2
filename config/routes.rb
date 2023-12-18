Rails.application.routes.draw do
  get 'rooms/index'
    root 'top#index'
  
    devise_for :users
  
    devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'#ログアウト可能
      
    end
  
    namespace 'users' do 
      resource :account, only: [:show, :edit]
      resource :profile, only: [:show, :edit, :update]
    end
   
  
    get 'users/index'

    resources :users do
      collection do
        get 'account'
        get 'profile'
       end
    end

    get "rooms/index"
     resources :rooms do
      collection do
        get 'own'
        get 'search'
       end
    end
   
    get 'reservations/index' => 'reservations#index'
    resources :reservations do
      collection do
        post "confirm", to:"reservations#confirm"
      end
  end 
  
end