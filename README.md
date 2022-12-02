# RuboCop Changed

Reduce RuboCop's CI time.

RuboCop extensions for lint only changed files in PRs.

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
