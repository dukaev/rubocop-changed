# frozen_string_literal: true

require './lib/rubocop-changed'

require 'rubocop/target_finder'
require 'rubocop/config_store'

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.raise_on_warning = true
  config.fail_if_no_examples = true

  config.order = :random
  Kernel.srand(config.seed)
end
