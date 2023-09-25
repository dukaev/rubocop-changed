# RuboCop Changed

Reduce RuboCop's CI time.

RuboCop extensions for lint only changed files in CI.

**Git is required** to work and assumes that the **.git folder** exists.

## Installation

Add gem to your `Gemfile`
```ruby
gem 'rubocop-changed'
```

## Usage

### RuboCop configuration file

Add to your `.rubocop_for_ci.yml` (for use only on CI):

```ruby
require: rubocop-changed
```

Or add argument:
```bash
rubocop --require rubocop-changed
```

## Additionally

The default branch for comparing gets by:
```bash
git symbolic-ref refs/remotes/origin/HEAD # usually it's main or master
```
For custom branch set env:  `RUBOCOP_CHANGED_BRANCH_NAME`

## Thanks
- [Steve Hall](https://github.com/sh41)

## Similar Gems

- [diffcop](https://github.com/yohira0616/diffcop)
- [rubocop-changes](https://github.com/fcsonline/rubocop-changes)
- [rubocop-git](https://github.com/m4i/rubocop-git)

The difference is the current extension didn't try to wrap RuboCop.
Instead, it just patched a small part of the code, which allows you to use `$ rubocop` as before.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dukaev/rubocop-changed. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/dukaev/rubocop-changed/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rubocop::Changed project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dukaev/rubocop-changed/blob/master/CODE_OF_CONDUCT.md).
