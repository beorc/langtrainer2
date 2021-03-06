Langtrainer2::Application.routes.draw do
  root to: 'main_page#show'

  constraints(UserDashboardConstraint) do
    get '/:username', to: 'user/dashboard#show', as: :user_dashboard
  end

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

  namespace :user do
    namespace :charts do
      ['boxes',
       'answers',
       'hints'].each do |key|
         get key => "#{key}#show"
       end
    end
  end

  put 'verify_answer' => 'unit_advances#verify_answer'
  put 'next_step' => 'unit_advances#next_step'
  put 'help_next_word' => 'unit_advances#help_next_word'
  put 'show_right_answer' => 'unit_advances#show_right_answer'

  resources :languages, only: [], path: '' do
    put 'set_native', on: :member

    resources :courses, only: [], path: '' do
      resources :units, only: :show, path: ''
    end

    get '/:language_id/:id', to: redirect('/%{language_id}/polyglot/%{id}')
  end

  resources :latest_contents, only: :index

  draw_fallback_routes
end
