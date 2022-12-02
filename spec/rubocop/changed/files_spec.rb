# frozen_string_literal: true

require 'spec_helper'

describe RuboCop::Changed::Files do
  subject { described_class.call(patterns) }

  let(:files) { ['/app/file1.rb', '/app/logic/file.rb', '/skip/file.rb'] }
  let(:patterns) { ['/app/*', '/app/**/*', '/app/logic/*'] }
  let(:result) { files - ['/skip/file.rb'] }

  before do
    allow(RuboCop::Changed::Commands).to receive(:changed_files).and_return(files)
  end

  context 'when patterns has more than one pattern' do
    it 'returns changed files' do
      expect(subject).to eq(result)
    end
  end

  context 'when no changed files' do
    let(:files) { [] }

    it 'returns empty array' do
      expect(subject).to eq(files)
    end
  end

  context 'when have changed files but no matching the pattern' do
    let(:patterns) { ['/unmatch/**/*'] }

    it 'returns empty array' do
      expect(subject).to eq([])
    end
  end

  context 'when patterns has one pattern' do
    let(:patterns) { ['/app/**/*'] }

    it 'returns changed files' do
      expect(subject).to eq(result)
    end
  end
end
