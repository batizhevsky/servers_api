require 'spec_helper'
require File.expand_path('../../../app/models/location', __FILE__)

RSpec.describe Location do
  before { stub_const('Location::AVAILABLE_DC', %w[first second]) }
  describe '#new' do
    it 'set name ok' do
      location = described_class.new('first')
      expect(location.name).to eq 'first'
    end

    it 'raise error when dc not from list' do
      expect { described_class.new('third') }.to raise_error(Location::UnknownType)
    end
  end

  describe '==' do
    let(:test_dc) { 'first' }
    subject { described_class.new(test_dc) }

    context 'same location' do
      let(:other_location) {  described_class.new(test_dc) }

      it { is_expected.to eq other_location }
    end

    context 'other location' do
      let(:other_location) {  described_class.new('second') }

      it { is_expected.to_not eq other_location }
    end
  end
end
