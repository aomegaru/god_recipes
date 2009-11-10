#
# The capistrano recipes to deploy god on servers
# That task is pretty simple. Capistrano manages the code updating by itself
# We only need to restart the God server
#

#
# We have the staging and production servers
#
set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

#
# But the application remains always the same
#
set :application, 'My god recipes'
set :repository,  'git@github.com:dmathieu/god.git'
set :scm, :git


namespace :deploy do
  task :finalize_update do
    # Removing the rails-centric task
  end
  #
  # We restart the god server
  #
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "god quit"
    run "cd #{release_path}; god -c god.rb"
  end
end