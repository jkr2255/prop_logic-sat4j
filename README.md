# PropLogic::Sat4j

Using [Sat4j](http://www.sat4j.org/) solver to boost [PropLogic](https://github.com/jkr2255/prop_logic), to practical level.

Note: This gem works only on JRuby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prop_logic-sat4j'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prop_logic-sat4j

## Usage
This gem internally require [PropLogic](https://github.com/jkr2255/prop_logic) gem, and automatically replaces `PropLogic.sat_sovler` to this gem's `PropLogic::Sat4j::Solver`.

Once loaded, you can benefit from Sat4j speed without rewriting codes for PropLogic.

### Incremental solver
In `PropLogic.sat_loop` and `PropLogic::Term#each_sat`, `PropLogic::Sat4j::IncrementalSolver#add` performs real incremental addition,
keeping learnt clauses.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Versioning
This gem is versioned respecting Sat4j's: Ver. a.b.c.d includes Sat4j Ver. a.b.c .

## Contributing

1. Fork it ( https://github.com/jkr2255/prop_logic-sat4j/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The same license as Sat4j ([EPL 1.0](http://www.eclipse.org/legal/epl-v10.html)/LGPL >= 2.1) is applied to this gem.

This gem includes Sat4j Ver. 2.3.5 binary with no modifications. The source code of Sat4j is available at [Sat4j project site](http://www.sat4j.org/).

