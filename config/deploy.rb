# Add location of gems to path on dreamhost shared
set :default_environment, {
  'PATH' => "/usr/lib/ruby/gems/1.8/bin/:$PATH"
}
set :bundle_without, [:test, :development]

require "bundler/capistrano"

server "helsinki.dreamhost.com", :web, :app, :db, primary: true

set :application, "explore.friendsofgrparks.org"
set :user, "friendsofgrparks"
set :scm, "git"
set :repository, "git@github.com:dgroulx/fgrp.git"
set :copy_remote_dir, "/home/#{user}"
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :copy
set :branch, "master"
set :git_shallow_clone, 1
set :scm_verbose, true

set :chmod755, "app config db lib public vendor script script/*"
set :use_sudo, false

after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  [:start, :stop].each do |t|
     desc "{t} task is a no-op with mod_rails"
     task t, :roles => :app do; end
  end

  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/application.example.yml"), "#{shared_path}/config/application.yml"
    puts "Now edit the config files in #{shared_path}"
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
       puts "WARNING: HEAD is not the same as origin/#{branch}"
       puts "Run `git push` to sync changes."
    end
  end
  before "deploy", "deploy:check_revision"

  desc "Reseed the database."
  task :reseed, roles: :app do
    run "cd '#{current_path}' && #{rake} db:seed RAILS_ENV=#{rails_env}"
  end
end

after "deploy:update_code", "deploy:symlink_config"
