require 'spec_helper'
require 'slugworth_shared_examples'
require 'slugworth'

ActiveRecord::Base.connection.execute(
  %{CREATE TABLE users (id INTEGER PRIMARY KEY, name STRING, slug STRING, age INTEGER);}
)

class User < ActiveRecord::Base
  include Slugworth
  slugged_with :name
end

describe User do
  it_behaves_like :has_slug_functionality
end

class ScopedUser < ActiveRecord::Base
  self.table_name = 'users'
  include Slugworth
  slugged_with :name, scope: :age
end

describe ScopedUser do
  it_behaves_like :has_scoped_slug_functionality
end
