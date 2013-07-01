require 'rspec'
require 'database_cleaner'

require 'active_support/concern'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3', database: ':memory:'
)

DatabaseCleaner.strategy = :truncation
