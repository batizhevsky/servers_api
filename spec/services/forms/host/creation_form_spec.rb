require 'rails_helper'

describe Forms::Host::CreationForm do
  describe '#call' do
    context 'all params passed' do
      it 'return new Host record' do
        host = subject.call({ name: 'one', type: 'server' })
        expect(host).to be_instance_of(::Host)
        expect(host).to be_persisted
      end
    end

    context 'one of params not passed' do
      it 'have not name' do
        expect { subject.call({  type: 'server' }) }.to raise_exception(Forms::ParamMissing)
      end

      it 'have not type' do
        expect { subject.call({ name: 'one' }) }.to raise_exception(Forms::ParamMissing)
      end
    end
  end
end
