app_root = File.expand_path '../../../shared', File.dirname(__FILE__)

env :PATH, ENV['PATH']

set :job_template, "bash -l -i -c ':job'"
set :environment, 'production'
set :output, "#{app_root}/log/cron_log.log"

every 1.day, :at => '4:20 am' do
   rake "sitemplate:backup:perform_all"
end
