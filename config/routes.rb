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

  put 'check_answer' => 'unit_advances#check_answer'
  put 'next_step' => 'unit_advances#next_step'
  put 'help_next_word' => 'unit_advances#help_next_word'
  put 'show_right_answer' => 'unit_advances#show_right_answer'

  resources :languages, only: [], path: '' do
    put 'set_native', on: :member

    resources :courses, only: [], path: '' do
      resources :units, only: :show, path: '' do
        member do
          get :revision
          get :training
        end
      end
    end

    get '/:language_id/:id', to: redirect('/%{language_id}/polyglot/%{id}')
  end

  draw_fallback_routes
end
