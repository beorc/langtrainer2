set :deploy_to, "/u/apps/test.#{fetch :application}"
# Где-то внутри капистрано shared_path запрашивается напрямую, без fetch. Опять
# Это означает, что для корректного переопределения deploy_to после загрузки  multistage-окружения
# нужно переопределить и shared_path
set :shared_path, "#{deploy_to}/shared"
# По той же причине нужно установить путь к pid-файлу unicorn'a заново
set :unicorn_pid, "#{fetch :shared_path}/pids/unicorn.pid"
