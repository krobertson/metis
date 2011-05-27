$:.unshift(File.dirname(__FILE__) + '/lib')
require 'metis'

dsl = Metis::DSL.new

puts "here goes"
dsl.read_file('exp/example.rb')
puts "done"
puts

puts "Hosts"
puts dsl.context.hosts.inspect
puts

puts "Roles"
puts dsl.context.roles.inspect
puts

puts "Checks"
puts dsl.context.checks.inspect
puts

puts "========== CONVERGE"
dsl.context.converge
puts
puts dsl.context.hosts.inspect

puts
puts "========== RUN"
dsl.context.monitor
