set :deploy_to, "/u/apps/#{fetch :application}"

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

after 'deploy:setup', 'sitemplate:backup:setup'
