ENV["RACK_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'rspec'
require 'capybara/dsl'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
Capybara.app = BikeShareApp

RSpec.configure do |c|
  c.before(:all) do
    DatabaseCleaner.clean
  end

  c.include Capybara::DSL

  c.after(:each) do
    DatabaseCleaner.clean
  end

end
