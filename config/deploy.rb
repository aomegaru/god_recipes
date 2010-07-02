#
# The capistrano recipes to deploy god on servers
# That task is pretty simple. Capistrano manages the code updating by itself
# We only need to restart the God server
#

set :deploy_to, "/home/dmathieu/god"
role :app, "173.203.89.159"
role :db, "173.203.89.159", :primary => true

#
# But the application remains always the same
#
set :application, 'My god recipes'
set :repository,  'git@github.com:idylnet/god_recipes.git'
set :scm, :git
set :user, "dmathieu"
set :use_sudo, false


namespace :deploy do
  task :finalize_update do
    # Removing the rails-centric task
  end
  task :migrate do
    # Removing the rails-centric task
  end
  task :migrations do
    # Removing the rails-centric task
  end
  #
  # We restart the god server
  #
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{sudo} god quit"
    run "cd #{current_path}; #{sudo} god -c god.rb"
  end
end

after 'deploy:update', 'deploy:restart'