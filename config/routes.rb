Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  
  resources :users
  resources :parameter_categories, :except => 'show'
  resources :parameters, :except => 'show'
  resources :criteria, :except => 'show'
  
  resources :articles do
    collection do
      get 'list'
    end
  end

  resources :documentations do
    collection do
      get 'list'
    end
  end 

  resources :locations, :except => 'show' do
    collection do
      get 'get_by_river'
    end
  end
  resources :analytics, :except => 'show' do
    collection do
      get 'filter'
    end
  end

  resources :discussions do 
    collection do
      get 'get_more_data'
    end
  end

  get '/home', to: 'home#index'
  get '/results/analytics', to: 'results#analytics'
  get '/results/analytics/chart', to: 'results#analytic_charts'
  get '/results/location', to: 'results#location'
  get '/results/get_all_location', to: 'results#get_all_location'
  get '/results/get_analytics', to: 'results#get_analytics'
  get '/results/get_analytic_charts', to: 'results#get_analytic_charts'
  get '/results/save_analytic_as_pdf', to: 'results#save_analytic_as_pdf'
  get '/results/save_analytic_chart_as_pdf', to: 'results#save_analytic_chart_as_pdf'
  get '/results/save_map_image_as_pdf', to: 'results#save_map_image_as_pdf'
  get '/download_history', to: 'download_histories#index'
  root to: 'home#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
