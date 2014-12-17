require 'rails_helper'

describe Forms::RackCabinet::DestroyForm do
  let!(:rack) { FactoryGirl.create :rack_cabinet }

  subject { described_class.new(rack) }

  describe '#call' do
    it 'destroy' do
      subject.call

      expect(RackCabinet).to_not be_exist(name: rack.name)
    end
  end
end
