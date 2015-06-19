require "bundler/gem_tasks"

require 'rake/extensiontask'
Rake::ExtensionTask.new do |ext|
  ext.name    = 'net_app_manageability'
  ext.ext_dir = 'ext/net_app_manageability'
  ext.lib_dir = 'lib/net_app_manageability'
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec => :compile)

task :default => :spec
