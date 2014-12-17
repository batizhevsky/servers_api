require 'rails_helper'

describe RackCabinetFilter do
  let(:scope) { class_double('RackCabinet') }
  subject { described_class.new(scope) }

  describe '#call' do
    it 'without filter' do
      expect(scope).to receive(:all)

      subject.call({})
    end

    it 'empty filter' do
      expect(scope).to receive(:without_hosts)

      subject.call({ state: :empty })
    end

    it 'multi_apc filter' do
      expect(scope).to receive(:with_multi)

      subject.call({ state: :multi_apc })
    end
  end
end
