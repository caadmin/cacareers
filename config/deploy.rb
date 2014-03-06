# Jekyll blog config/deploy.rb file
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'    # for rvm support. (http://rvm.io)

set :domain, '162.243.133.244'
set :deploy_to, '/home/webmaster/cacareers'
set :repository, 'git://github.com/caadmin/cacareers'
set :branch, 'master'

# Optional settings:
set :user, 'webmaster'    # Username in the server to SSH to.
set :term_mode, nil

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rvm:use[ruby-2.1.1]'
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'bundle:install'
    queue "#{bundle_prefix} jekyll build"
  end
end
