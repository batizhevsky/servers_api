require 'rails_helper'

describe Forms::Host::UpdateForm do
  let!(:host) { FactoryGirl.create :host, name: 'a', type: 'server' }

  subject { described_class.new(host) }

  describe '#call' do
    it 'update name' do
      params = { name: 'new' }
      updated_subj = subject.call(params)

      expect(updated_subj.name).to eq 'new'
    end
  end
end
