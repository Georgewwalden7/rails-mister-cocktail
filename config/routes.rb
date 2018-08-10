Rails.application.routes.draw do
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'cocktails#index'
  resources :cocktails, except: :index do
    resources :doses, only: [:create, :new, :index, :show]
  end
  delete "/doses/:id", to: 'doses#destroy', as: :delete_dose
end

Rails.application.routes.draw do
  root to: 'articles#index'
  resources :articles, except: :index
end
