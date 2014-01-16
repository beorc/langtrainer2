Langtrainer2::Application.routes.draw do
  resources :unit_statistics

  root to: 'main_page#show'
  draw_sitemplate_core_routes

  devise_opts = {
    controllers: {}
  }
  draw_devise_routes(devise_opts)

  mount RedactorRails::Engine => '/redactor_rails'

  namespace :admin do
    resources :courses
    resources :units
    resources :steps
    resources :step_mappings
    resources :useful_links
  end

  put 'step_passed' => 'unit_statistics#step_passed'
  put 'word_helped' => 'unit_statistics#word_helped'
  put 'step_helped' => 'unit_statistics#step_helped'
  put 'right_answer' => 'unit_statistics#right_answer'
  put 'wrong_answer' => 'unit_statistics#wrong_answer'

  put 'box_up' => 'boxes#box_up'
  put 'box_down' => 'boxes#box_down'

  resources :languages, only: [], path: '' do
    put 'set_native', on: :member

    resources :courses, only: [], path: '' do
      resources :units, only: :show, path: ''
    end

    get '/:language_id/:id', to: redirect('/%{language_id}/polyglot/%{id}')
  end

  draw_fallback_routes
end
