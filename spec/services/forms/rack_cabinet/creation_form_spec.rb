require 'rails_helper'

describe Forms::RackCabinet::CreationForm do
  describe '#call' do
    context 'all params passed' do
      it 'return new RackCabinet record' do
        rack_cabinet = subject.call({ name: 'one', location: 'dc1' })
        expect(rack_cabinet).to be_instance_of(::RackCabinet)
        expect(rack_cabinet).to be_persisted
      end
    end

    context 'one of params not passed' do
      it 'have not name' do
        expect { subject.call({ location: 'dc1' }) }.to raise_exception(Forms::ParamMissing)
      end

      it 'have not location' do
        expect { subject.call({ name: 'one' }) }.to raise_exception(Forms::ParamMissing)
      end
    end
  end
end
