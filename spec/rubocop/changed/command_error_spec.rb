# frozen_string_literal: true

require 'spec_helper'

describe RuboCop::Changed::CommandError do
  subject { described_class.new(output, cmd).to_s }

  context 'when git command is not found' do
    let(:cmd) { 'git rev-parse --abbrev-ref HEAD' }
    let(:output) { 'git: not found' }

    it 'returns error message' do
      expect(subject).to eq('Git is not installed. Make shure that container has git installed')
    end
  end

  context 'when .git directory is not found' do
    let(:cmd) { 'git status' }
    let(:output) { 'fatal: not a git repository (or any of the parent directories): .git' }

    it 'returns error message' do
      expect(subject).to eq('Not found .git directory. Make shure that branch is copied')
    end
  end

  context 'when settetd branch is not found' do
    let(:cmd) { 'git diff-tree -r --no-commit-id --name-only not_found_branch' }
    let(:output) { "fatal: ambiguous argument 'not_found_branch': unknown revision or path not in the working tree." }

    it 'returns error message' do
      expect(subject).to eq('Not found setted branch. Make shure that branch is downladed.')
    end
  end

  context 'when unknown error' do
    let(:cmd) { 'git status' }
    let(:output) { 'fatal: unknown error' }
    let(:message) do
      <<~HEREDOC
        Unknown error. Please, create issue on #{RuboCop::Changed::CommandError::ISSUE_URL}.
        Command: #{cmd}
        Message: #{output}
      HEREDOC
    end

    it 'returns error message' do
      expect(subject).to eq(message)
    end
  end
end
