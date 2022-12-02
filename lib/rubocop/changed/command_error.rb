# frozen_string_literal: true

module RuboCop
  module Changed
    # This class get changed
    class CommandError < StandardError
      ISSUE_URL = 'https://github.com/dukaev/rubocop-changed/issues'
      MESSAGES = {
        'git: not found' => 'Git is not installed. Make shure that container has git installed',
        'fatal: not a git repository' => 'Not found .git directory. Make shure that branch is copied',
        'fatal: ambiguous argument' => 'Not found setted branch. Make shure that branch is downladed.'
      }.freeze

      def initialize(output, cmd)
        key = MESSAGES.keys.find { |error| output.include?(error) }
        msg = MESSAGES[key] || default_message(cmd, output)

        super(msg)
      end

      def default_message(cmd, output)
        <<~HEREDOC
          Unknown error. Please, create issue on #{ISSUE_URL}.
          Command: #{cmd}
          Message: #{output}
        HEREDOC
      end
    end
  end
end
