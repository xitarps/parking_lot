require 'simplecov'

SimpleCov.start

ENV['SINATRA_ENV'] = 'test'
ENV['MONGOID_ENV'] = 'test'

require 'rack/test'
require 'rspec'
require 'active_support/testing/time_helpers'

Dir.glob('./config/initializers/*.rb').each { |file| require file }

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include ActiveSupport::Testing::TimeHelpers
  config.include JsonHelper
end
