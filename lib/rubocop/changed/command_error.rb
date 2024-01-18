# frozen_string_literal: true

module RuboCop
  module Changed
    # This class get changed
    class CommandError < StandardError
      ISSUE_URL = 'https://github.com/dukaev/rubocop-changed/issues'
      MESSAGES = {
        'git: not found' =>
          'The git binary is not available in the PATH. You may need to install git or update the PATH variable to ' \
          'include the installation directory.',
        'fatal: not a git repository' =>
          'The .git directory was not found. Rubocop-changed only works with projects in a git repository.',
        'fatal: ambiguous argument' =>
          'The set branch was not found. Ensure that the branch has a local tracking branch or specify the full ' \
          'reference in the RUBOCOP_CHANGED_BRANCH_NAME environment variable.'
      }.freeze

      def initialize(output, cmd)
        key = MESSAGES.keys.find { |error| output.include?(error) }
        message = MESSAGES[key] || "Unknown error. Please, create issue on #{ISSUE_URL}."
        super(exception_message(cmd, output, message))
      end

      def exception_message(cmd, output, message)
        <<~HEREDOC
          #{message}
          Command:
          #{cmd}
          Output:
          #{output}

        HEREDOC
      end
    end
  end
end
