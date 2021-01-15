require "rspec"
require "database_cleaner"
require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3", database: ":memory:"
)

RSpec.configure do |config|
  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
