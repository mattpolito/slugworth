require 'spec_helper'
require 'slugworth_shared_examples'
require 'slugworth'

ActiveRecord::Base.connection.execute(
  %{CREATE TABLE users (id INTEGER PRIMARY KEY, name STRING, slug STRING);}
)

class User < ActiveRecord::Base
  include Slugworth
  slugged_with :name
end

describe User do
  it_behaves_like :has_slug_functionality
end
