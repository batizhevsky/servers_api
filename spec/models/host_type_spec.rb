require 'spec_helper'
require File.expand_path('../../../app/models/host_type', __FILE__)

RSpec.describe HostType do
  before { stub_const('HostType::AVAILABLE_TYPES', %w[first second]) }
  describe '#new' do
    it 'set type ok' do
      location = described_class.new('first')
      expect(location.type).to eq 'first'
    end

    it 'raise error when type not from list' do
      expect { described_class.new('third') }.to raise_error(HostType::UnknownType)
    end
  end

  describe '==' do
    let(:test_type) { 'first' }
    subject { described_class.new(test_type) }

    context 'same type' do
      let(:other_type) {  described_class.new(test_type) }

      it { is_expected.to eq other_type }
    end

    context 'other type' do
      let(:other_type) {  described_class.new('second') }

      it { is_expected.to_not eq other_type }
    end
  end
end
