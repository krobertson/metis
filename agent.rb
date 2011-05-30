$:.unshift(File.dirname(__FILE__) + '/lib')
require 'metis'

context = Metis::AgentContext.new

puts "here goes"
context.read_file('exp/solo_example.rb')
puts "done"
puts

puts "Checks"
puts context.checks.inspect
puts

puts
puts "========== RUN"
context.begin
