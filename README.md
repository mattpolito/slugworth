![Slugworth](http://f.cl.ly/items/3T1K3g040S0u2l0G0d3V/slugworth_header.png)

[![Gem Version](https://badge.fury.io/rb/slugworth.png)](http://badge.fury.io/rb/sluggle)
[![Build Status](https://travis-ci.org/mattpolito/slugworth.png?branch=master)](https://travis-ci.org/mattpolito/slugworth)
[![Code Climate](https://codeclimate.com/github/mattpolito/slugworth.png)](https://codeclimate.com/github/mattpolito/slugworth)

Simple slug functionality for your ActiveRecord objects

## Installation

Add this line to your application's Gemfile:

```shell
  gem 'slugworth'
```

and then execute

```shell
  bundle
```

or

install it yourself with

```shell
  gem install slugworth
```

## Usage

Getting started is easy! Just ensure that your model has a database column of type `String` called `slug`

To use, just add two declarations to your `ActiveRecord` class and away you go!

```ruby
class User < ActiveRecord::Base
  include Slugworth
  slugged_with :name
end
```

After you `include` the `Slugworth` module, all you need to do is declare what method will be used to create the slug. The method passed to `slugged_with` will then be paramterized.

This provides most of the default slug functionality you would need.

* Finders `.find_by_slug` & `.find_by_slug!` are provided. This will, of course, do what you expect and find a single record by the slug attribute provided.
* `#to_param` has been defined as a paramaterized version of the attribute declared to `slugged_with`.
* Validations stating that `slug` is present and unique in the database.

### Scoping uniqueness

By default the slug is unique to the entire table, but you can specify the scope of the uniqueness as the following:

```ruby
class Product < ActiveRecord::Base
  include Slugworth
  belongs_to :user
  slugged_with :name, scope: :user_id
end
```

## Test Helper

To aid in testing your models that implement the Slugworth functionality, I've added a shared example group that can be added to your test suite. Add this to your `spec_helper.rb`

```ruby
include 'slugworth_shared_examples'
```

And then in your specs just add:

```ruby
it_behaves_like :has_slug_functionality
```

This will add the same specs to your model that get run on Slugworth itself!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks

* [Rye Mason][] for the fantastic heading image.

[Rye Mason]: https://github.com/ryenotbread
