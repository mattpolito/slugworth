![Slugworth](http://f.cl.ly/items/3T1K3g040S0u2l0G0d3V/slugworth_header.png)

[![Gem Version](https://badge.fury.io/rb/slugworth.png)](http://badge.fury.io/rb/sluggle)
[![Build Status](https://travis-ci.org/mattpolito/slugworth.png?branch=master)](https://travis-ci.org/mattpolito/sluggle)
[![Code Climate](https://codeclimate.com/github/mattpolito/slugworth.png)](https://codeclimate.com/github/mattpolito/sluggle)

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

* A finder `.find_by_slug` is provided. This will, of course, do what you expect and find a single record by the slug attribute provided. However, it will throw an `ActiveRecord::RecordNotFound` exception... if not found.
* `#to_param` has been defined as a paramaterized version of the attribute declared to `slugged_with`.
* Validations stating that `slug` is present and unique in the database.

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
