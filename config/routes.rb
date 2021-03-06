Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :products, only: [:show, :index, :create, :update, :destroy]
    end
  end

  root 'welcome#index'
  get '/about' => 'welcome#about'
  get '/contact' => 'welcome#contact'
  post '/contact_submit' => 'welcome#contact_submit'

  namespace :admin do
    resources :dashboard, only: [:index]
  end

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  # get '/products' => 'products#index'
  # delete '/questions/:id' => 'products#destroy'
  # get '/questions/:id/edit' => 'products#edit'
  # get '/questions/:id' => 'products#show'
  # post '/questions/:id/comments' => 'comments#create'

  get '/faq' =>'home#faq'

  # get '/admin/products' => 'admin/products#index'

  # get '/products/new'   => 'products#new', as: :new_product
  # post '/products'      => 'products#create', as: :products
  # get '/products/:id'   => 'products#show', as: :product
  # get '/products'       => 'products#index'
  #
  #
  # delete '/products/:id' => 'products#destroy'
  #
  #
  # get '/product/:id/edit' => 'products#edit', as: :edit_product
  #
  # patch '/products/:id' => 'products#update'

  resources :products, shallow: true do
    resources :reviews, only:[:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :users, only:[:new, :create, :show]

  resources :sessions, only:[:new, :create] do
    delete :destroy, on: :collection
  end


end
