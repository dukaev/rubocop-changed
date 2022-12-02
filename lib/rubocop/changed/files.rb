# frozen_string_literal: true

module RuboCop
  module Changed
    # This class get changed files matching the pattern.
    class Files
      class << self
        def call(patterns)
          files = RuboCop::Changed::Commands.changed_files
          filter(patterns, files)
        end

        private

        def filter(patterns, files)
          # Matching Dir.glob by pattern has difference with File.fnmatch.
          # To match files on first level of directory, we need additional pattern with `*`.
          # Covers case for find_files(...) in RuboCop::TargetFinder:
          # `patterns = [File.join(base_dir, '**/*')] if patterns.empty?`
          if patterns.one? && patterns.first.end_with?('/**/*')
            pattern = patterns.first.gsub('/**/*', '/*')
            patterns << pattern
          end

          union_patterns = "{#{patterns.join(',')}}"
          files.select { |file| File.fnmatch(union_patterns, file, File::FNM_EXTGLOB) }
        end
      end
    end
  end
end
