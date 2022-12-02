# frozen_string_literal: true

module RuboCop
  module Changed
    # This class get changed
    class Commands
      ERRORS = [
        'git: command not found',
        'fatal:'
      ].freeze
      GIT_COMMANDS = {
        changed_files: 'git diff-tree -r --no-commit-id --name-status %<compared_branch>s %<current_branch>s',
        current_branch: 'git rev-parse --abbrev-ref HEAD',
        default_branch: 'git symbolic-ref refs/remotes/origin/HEAD'
      }.freeze

      class << self
        def changed_files(branch = compared_branch)
          command = format(
            GIT_COMMANDS.fetch(:changed_files),
            compared_branch: branch,
            current_branch: current_branch
          )
          run(command)
            .split("\n")
            .filter_map { |line| line.split("\t").last unless line.match?(/D\t/) }
            .map { |file| File.absolute_path(file) }
        end

        def compared_branch
          branch = setted_branch || default_branch
          raise ArgumentError, 'You can not compare branch with itself' if branch == current_branch

          branch
        end

        private

        def current_branch
          run(GIT_COMMANDS.fetch(:current_branch)).gsub("\n", '')
        end

        def setted_branch
          ENV.fetch('RUBOCOP_CHANGED_BRANCH_NAME', nil)
        end

        def default_branch
          run(GIT_COMMANDS.fetch(:default_branch))
            .gsub(%r{refs/remotes/origin/|\n}, '')
        end

        def run(cmd)
          output = shell(cmd)
          raise Rubocop::Changed::ExecutionError.new(output, cmd) if output.match?(Regexp.union(ERRORS))

          output
        end

        def shell(cmd)
          `#{cmd} 2>&1`
        end
      end
    end
  end
end
