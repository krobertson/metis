require 'rubygems'
require 'fileutils'
require 'rake'
require 'rspec/core/rake_task'

desc "Run all specs"
RSpec::Core::RakeTask.new('spec') do |t|
  t.rcov = true
  t.rcov_opts = %w{--exclude osx\/objc,gems\/,spec\/,features\/,rake\/,Gemfile,yaml,eval,FORWARDABLE,DELEGATE,jar --aggregate coverage.data}
  t.rcov_opts << %[-o "coverage"]
  t.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec
