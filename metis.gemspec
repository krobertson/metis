$:.unshift(File.dirname(__FILE__) + '/lib')
require 'metis/version'

Gem::Specification.new do |s|
  s.name = 'metis'
  s.version = Metis::VERSION
  s.platform = Gem::Platform::RUBY
  #s.extra_rdoc_files = ["README.md", "LICENSE" ]
  s.summary = "A server monitoring framework built to bring flexible and testable monitoring to your entire infrastructure."
  s.description = s.summary
  s.author = "Ken Robertson"
  s.email = "ken@invalidlogic.com"
  s.homepage = "http://github.com/krobertson/metis"

  s.add_dependency "ohai", ">= 0.5.7"

  s.bindir       = "bin"
  s.executables  = %w( metis )
  s.require_path = 'lib'
  s.files = Dir.glob("lib/**/*")
end
