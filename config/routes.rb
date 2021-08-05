Rails
  .application
  .routes
  .draw do
    root to: 'bank/accounts#show'

    namespace :bank do
      resource :account, only: :show
      resources :transactions, only: :create
    end
  end
