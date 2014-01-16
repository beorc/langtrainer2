require 'rvm/capistrano'
require 'bundler/capistrano'
require 'capistrano_colors'

require 'capistrano/sitemplate_core_recipes'

set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, 'langtrainer2'
set :domain, 'p2.httplab.ru'

set :rollbar_token, fetch_config_value(:rollbar_token)

set :user, 'apps'
set :use_sudo, false

set :scm, :git
set :repository, 'git@github.com:beorc/langtrainer2.git'
set :branch, 'master'
set :git_shallow_clone, 1

role :web, domain
role :app, domain
role :db, domain, :primary => true

set :deploy_via, :copy
set :copy_exclude, %w(.git)

set :rvm_type, :user
set :rvm_ruby_string, fetch_config_value(:ruby_version)

set :unicorn_pid, "#{fetch :shared_path}/pids/unicorn.pid"
set :rails_env, :production
set :rack_env, :production

after 'deploy:setup', 'deploy:db:default_config', 'sitemplate:default_app_config'
after 'deploy:finalize_update', 'deploy:symlink_shared'
after 'deploy:setup', 'deploy:create_shared_dirs'
after 'deploy', 'deploy:migrate'
after 'deploy', 'deploy:notify_rollbar' unless fetch(:rollbar_token, nil)

after 'deploy:stop', 'unicorn:stop'
after 'deploy:start', 'unicorn:start'
after 'deploy:restart', 'unicorn:stop', 'unicorn:start'

require 'capistrano-unicorn'
require './config/boot'
