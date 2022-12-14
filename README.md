# RuboCop Changed

Reduce RuboCop's CI time.

RuboCop extensions for lint only changed files in CI.

## Installation

Add gem to your `Gemfile`
```
gem 'rubocop-changed'
```

## Usage

### RuboCop configuration file

Add to your `.rubocop_for_ci.yml` (for use only on CI):

```
require: rubocop-changed
```

Or add argument:
```
rubocop --require rubocop-changed
```

## Additionally

By default, we use a branch returned from:
```
git symbolic-ref refs/remotes/origin/HEAD
```
For the custom branch set `RUBOCOP_CHANGED_BRANCH_NAME`. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dukaev/rubocop-changed. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/dukaev/rubocop-changed/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rubocop::Changed project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dukaev/rubocop-changed/blob/master/CODE_OF_CONDUCT.md).