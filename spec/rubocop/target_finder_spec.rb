# frozen_string_literal: true

require 'spec_helper'

describe RuboCop::TargetFinder do
  subject do
    described_class
      .new(RuboCop::ConfigStore.new)
      .find_files(Dir.getwd, flags)
  end

  let(:flags) { 4 }
  let(:staged_files) { RuboCop::Changed::Files }

  before do
    allow(Dir).to receive(:glob).and_call_original
    allow(staged_files).to receive(:call).and_return([])
  end

  it 'calls find_files' do
    expect(Dir).to receive(:glob).at_least(:twice)
    expect(subject).to be_a(Array)
    expect(staged_files).to have_received(:call).once
  end
end
