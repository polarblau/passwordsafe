require 'bundler'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new do |t|
  t.verbose = true
end

Cucumber::Rake::Task.new(:features)

task :default => [:spec, :features]

require 'rake/clean'
CLEAN.include %w(**/*.{log,pyc,rbc,tgz} doc)
