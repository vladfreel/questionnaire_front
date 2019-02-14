Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions
  resources :answers
  get '/update_question', to: 'questions#update_question', as: 'update_question'
  get '/update_answer', to: 'answers#update_answer', as: 'answer_question'
  root to: 'questions#index'
end
