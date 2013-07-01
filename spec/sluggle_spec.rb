require 'spec_helper'
require 'sluggle_shared_examples'
require 'sluggle'

ActiveRecord::Base.connection.execute(
  %{CREATE TABLE users (id INTEGER PRIMARY KEY, name STRING, slug STRING);}
)

class User < ActiveRecord::Base
  include Sluggle
  slugged_with :name
end

describe User do
  it_behaves_like :has_slug_functionality
end
