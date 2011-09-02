# Add the root to the load path.
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'bundler'
Bundler.require
require 'rspec'

require 'metis'
