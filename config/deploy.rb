require "bundler/capistrano"

server "helsinki.dreamhost.com", :web, :app, :db, primary: true

set :scm, "git"
set :repository, "git@github.com:dgroulx/fgrp.git"
set :deploy_via, :remote_cache
set :branch, "master"
set :git_shallow_clone, 1
set :scm_verbose, true

set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

after "deploy:restart", "deploy:cleanup"

