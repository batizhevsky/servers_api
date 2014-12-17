require 'rails_helper'

describe Forms::Host::DestroyForm do
  let!(:host) { FactoryGirl.create :host }

  subject { described_class.new(host) }

  describe '#call' do
    it 'destroy' do
      subject.call

      expect(Host).to_not be_exist(name: host.name)
    end
  end
end
