Rails.application.routes.draw do
  get 'order/new'
  get 'welcome/works'
  post '/welcome/create'
  post 'to_do_task/submitCheckboxVal'
  post 'to_do_task/refreshMonthView' => 'to_do_task#refreshMonthView'
  post 'to_do_task/refreshDayView' => 'to_do_task#refreshDayView'



  devise_for :users, controllers: { registrations: 'users/registrations',sessions: 'users/sessions' }
  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users do
    resources :order
    get 'to_do_task/displayMonthView' => 'to_do_task#displayMonthView'
    get 'to_do_task/displayDayView' => 'to_do_task#displayDayView'


    resources :to_do_task
    get 'order/listallOrders'


  end

  root 'welcome#welcome'

end
