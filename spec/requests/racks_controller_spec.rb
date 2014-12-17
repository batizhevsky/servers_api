require 'rails_helper'

RSpec.describe Api::RacksController do
  describe 'index' do

    describe 'show list of racks' do
      let!(:racks) { FactoryGirl.create_list :rack_cabinet, 5 }
      before { get '/api/racks' }

      it { expect(response).to  have_http_status(:success) }
      it { expect(api_response.map {|r| r[:id] }).to be_include(racks.sample.id) }
      it { expect(api_response.sample).to have_key(:name) }
      it { expect(api_response.sample).to have_key(:location) }
    end

    describe 'filter racks without hosts' do
      let!(:rack_with_server) { FactoryGirl.create :rack_cabinet, :with_server }
      let!(:empty_rack) { FactoryGirl.create :rack_cabinet }

      before { get '/api/racks?state=empty' }

      it { expect(response).to have_http_status(:success) }
      it { expect(api_response.map {|r| r[:id] }).to be_include(empty_rack.id) }
      it { expect(api_response.map {|r| r[:id] }).to_not be_include(rack_with_server.id) }
    end

    describe 'filter racks with many APC' do
      let!(:rack_multi_apc) { FactoryGirl.create :rack_cabinet, :with_multi_apc }
      let!(:empty_rack) { FactoryGirl.create :rack_cabinet }

      before { get '/api/racks?state=multi_apc' }

      it { expect(response).to have_http_status(:success) }
      it { expect(api_response.map {|r| r[:id] }).to be_include(rack_multi_apc.id) }
      it { expect(api_response.map {|r| r[:id] }).to_not be_include(empty_rack.id) }
    end
  end

  describe :create do
    it 'create new rack ' do
      post '/api/racks', { name: 'test rack', location: 'dc2' }

      expect(response).to have_http_status(:created)
      expect(api_response[:name]).to eq 'test rack'
      expect(api_response[:location]).to eq 'dc2'
    end
  end

  describe :show do
    let!(:rack) { FactoryGirl.create(:rack_cabinet, name: 'old', location: 'dc2') }

    it 'show rack ' do
      get "/api/racks/#{ rack.id }"

      expect(response).to have_http_status(:success)
      expect(api_response[:id]).to eq rack.id
    end
  end

  describe :update do
    let!(:rack) { FactoryGirl.create(:rack_cabinet, name: 'old', location: 'dc2') }

    it 'rack attrs' do
      put "/api/racks/#{ rack.id }", name: 'new rack', location: 'dc1'

      expect(response).to have_http_status(:success)
      expect(api_response[:name]).to eq 'new rack'
      expect(api_response[:location]).to eq 'dc1'
    end
  end

  describe :destroy do
    let!(:rack) { FactoryGirl.create(:rack_cabinet, name: 'old', location: 'dc2') }

    it 'remove record from db' do
      delete "/api/racks/#{ rack.id }"

      expect(response).to have_http_status(:success)

      expect(RackCabinet.find_by(id: rack)).to_not be
    end
  end
end
