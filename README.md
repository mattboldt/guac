# GitPa

GitPa is a command-line program to manage multiple local git repos with one command. `GitPa` is the working title of a the gem.

## Installation

    $ gem install git_pa

## Usage

```bash
# Run setup
git_pa config

# Show status
git_pa status

# Update all on master
git_pa up -b master
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mattboldt/git_pa. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the GitPa project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mattboldt/git_pa/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2018 Matt Boldt. See [MIT License](LICENSE.txt) for further details.
