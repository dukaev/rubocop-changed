# frozen_string_literal: true

require 'spec_helper'

describe RuboCop::Changed::Commands do
  before do
    allow(ENV).to receive(:fetch).with('RUBOCOP_CHANGED_BRANCH_NAME', nil).and_return(setted_branch)
    changed_files_command = format(
      git[:changed_files],
      compared_branch: default_branch,
      current_branch: current_branch
    )
    allow(described_class).to(receive(:shell).with(changed_files_command).and_return(files.join("\n")))
    allow(described_class).to(receive(:shell).with(git[:current_branch]).and_return(current_branch))
    allow(described_class).to(receive(:shell).with(git[:default_branch]).and_return(default_branch))
  end

  let(:git) { RuboCop::Changed::Commands::GIT_COMMANDS }
  let(:setted_branch) { 'setted_branch' }
  let(:default_branch) { 'main' }
  let(:current_branch) { 'dev' }
  let(:files) { ['file1.rb', 'file2.rb'] }

  context 'when returns default_branch' do
    let(:setted_branch) { nil }

    it 'returns default branch' do
      expect(ENV).to receive(:fetch).with('RUBOCOP_CHANGED_BRANCH_NAME', nil)
      expect(described_class).to receive(:shell).with(git[:current_branch])
      expect(described_class).to receive(:shell).with(git[:default_branch])
      expect(described_class.compared_branch).to eq(default_branch)
    end
  end

  context 'when returns setted_branch' do
    let(:setted_branch) { 'setted_branch' }

    it 'returns setted branch' do
      expect(ENV).to receive(:fetch).with('RUBOCOP_CHANGED_BRANCH_NAME', nil)
      expect(described_class).to receive(:shell).with(git[:current_branch])
      expect(described_class).not_to receive(:shell).with(git[:default_branch])
      expect(described_class.compared_branch).to eq(setted_branch)
    end
  end

  context 'when compared_branch is current_branch' do
    let(:setted_branch) { 'dev' }

    it 'raises ArgumentError' do
      expect(ENV).to receive(:fetch).with('RUBOCOP_CHANGED_BRANCH_NAME', nil)
      expect(described_class).to receive(:shell).with(git[:current_branch])
      expect { described_class.compared_branch }.to raise_error(ArgumentError)
    end
  end

  context 'when returns changed_files' do
    it 'returns changed files' do
      expect(described_class).to receive(:shell).with(format(git[:changed_files], compared_branch: default_branch,
                                                                                  current_branch: current_branch))
      expect(described_class.changed_files('main')).to eq(files.map { |file| File.absolute_path(file) })
    end
  end
end
