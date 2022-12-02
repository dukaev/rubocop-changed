# frozen_string_literal: true

class RuboCop::TargetFinder
  # Override Dir.glob for find_files method.
  # Dir.glob calls only with two types of flags.
  # For case when need to find files will be used RuboCop::Changed::Files.call
  class Dir < ::Dir
    def self.glob(patterns, flags)
      flags == 4 ? RuboCop::Changed::Files.call(patterns) : super
    end
  end
end
