require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/bundler"
require 'capistrano/rails'
require "capistrano/rails/migrations"
require "capistrano/rails/assets"
require "capistrano/scm/git"
require 'capistrano/rvm'
require 'capistrano/puma'

install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Workers
install_plugin Capistrano::Puma::Nginx

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

# require "capistrano/rbenv"
# require "capistrano/chruby"
# require "capistrano/passenger"