require 'rails_helper'

describe Forms::RackCabinet::UpdateForm do
  let!(:rack) { FactoryGirl.create :rack_cabinet, name: 'a', location: 'dc1' }

  subject { described_class.new(rack) }

  describe '#call' do
    it 'update name' do
      params = { name: 'new' }
      updated_subj = subject.call(params)

      expect(updated_subj.name).to eq 'new'
    end

    it 'update location' do
      params = { location: 'dc2' }
      updated_subj = subject.call(params)

      expect(updated_subj.dc_location).to eq Location.new('dc2')
    end
  end
end
