# frozen_string_literal: true

require 'spec_helper'

describe RuboCop::Changed::CommandError do
  subject { described_class.new(output, cmd).to_s }

  context 'when git command is not found' do
    let(:cmd) { 'git rev-parse --abbrev-ref HEAD' }
    let(:output) { 'git: not found' }
    let(:exception_help_string) do
      'The git binary is not available in the PATH. ' \
        'You may need to install git or update the PATH variable to include the installation directory.'
    end

    it 'returns error message' do
      expect(subject).to eq(expected_error_as_string(exception_help_string, cmd, output))
    end
  end

  context 'when .git directory is not found' do
    let(:cmd) { 'git status' }
    let(:output) { 'fatal: not a git repository (or any of the parent directories): .git' }
    let(:exception_help_string) do
      'The .git directory was not found. Rubocop-changed only works with projects in a git repository.'
    end

    it 'returns error message' do
      expect(subject).to eq(expected_error_as_string(exception_help_string, cmd, output))
    end
  end

  context 'when set branch is not found' do
    let(:cmd) { 'git diff-tree -r --no-commit-id --name-only not_found_branch' }
    let(:output) { "fatal: ambiguous argument 'not_found_branch': unknown revision or path not in the working tree." }
    let(:exception_help_string) do
      'The set branch was not found. Ensure that the branch has a local tracking branch or specify the full ' \
        'reference in the RUBOCOP_CHANGED_BRANCH_NAME environment variable.'
    end

    it 'returns error message' do
      expect(subject).to eq(expected_error_as_string(exception_help_string, cmd, output))
    end
  end

  context 'when unknown error' do
    let(:cmd) { 'git status' }
    let(:output) { 'fatal: unknown error' }
    let(:exception_help_string) do
      "Unknown error. Please, create issue on #{RuboCop::Changed::CommandError::ISSUE_URL}."
    end

    it 'returns error message' do
      expect(subject).to eq(expected_error_as_string(exception_help_string, cmd, output))
    end

    it 'contains a link to github' do
      expect(subject).to match('https://github.com/dukaev/rubocop-changed/')
    end
  end

  def expected_error_as_string(message, command, output)
    <<~HEREDOC
      #{message}
      Command:
      #{command}
      Output:
      #{output}

    HEREDOC
  end
end
