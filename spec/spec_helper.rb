ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(Rails)
require 'rspec/rails'

Factory.find_definitions

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Rspec.configure do |config|
  config.mock_with :rspec
  config.before(:each) do
    Mongoid.master.collections.reject{|c| c.name == 'system.indexes'}.each(&:drop)
  end
end
