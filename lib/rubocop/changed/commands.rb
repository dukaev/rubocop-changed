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
        default_branch: "git remote show origin | sed -n '/HEAD branch/s/.*: //p' | xargs",
        new_files: 'git status --porcelain=v1'
      }.freeze

      class << self
        def changed_files(branch = compared_branch)
          (diffed_files(branch) + new_files).uniq
        end

        def diffed_files(branch = compared_branch)
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

        def new_files
          command = format(GIT_COMMANDS.fetch(:new_files))
          run(command).split("\n")
                      .map { |file| File.absolute_path(file[3..]) }
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
          warn("COMMAND: #{cmd}") if verbose_logging?
          output = shell(cmd)
          warn("OUTPUT:  #{output}\n") if verbose_logging?
          raise CommandError.new(output, cmd) if output.match?(Regexp.union(ERRORS))

          output
        end

        def shell(cmd)
          `#{cmd} 2>&1`
        end

        def verbose_logging?
          ENV.fetch('RUBOCOP_CHANGED_VERBOSE_LOGGING', false) != false
        end
      end
    end
  end
end
