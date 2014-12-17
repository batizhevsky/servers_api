require 'rails_helper'

RSpec.describe Api::HostsController do
  describe 'index' do

    describe 'show list of hosts' do
      let!(:hosts) { FactoryGirl.create_list :host, 5 }
      before { get '/api/hosts' }

      it 'have fields and records' do
        expect(response).to  have_http_status(:success)

        expect(api_response.map {|r| r[:id] }).to be_include(hosts.sample.id)
        expect(api_response.sample).to have_key(:name)
        expect(api_response.sample).to have_key(:type)
        expect(api_response.sample).to have_key(:rack_id)
      end
    end

    describe 'same rack hosts' do
      let!(:rack) { FactoryGirl.create :rack_cabinet }
      let!(:other_rack) { FactoryGirl.create :rack_cabinet }

      let!(:tested) { FactoryGirl.create :host, rack: rack}
      let!(:same_rack) { FactoryGirl.create :host, rack: rack }
      let!(:host_in_other_rack) { FactoryGirl.create :host, rack: other_rack }

      before { get "/api/hosts?in_same_rack=#{tested.id}" }

      it 'have fields and records' do
        expect(response).to  have_http_status(:success)

        expect(api_response.map {|r| r[:id] }).to be_include(tested.id)
        expect(api_response.map {|r| r[:id] }).to be_include(same_rack.id)
        expect(api_response.map {|r| r[:id] }).to_not be_include(host_in_other_rack.id)
      end
    end

    describe 'filter by type' do
      let!(:apc) { FactoryGirl.create :host, type: 'apc'}
      let!(:switch) { FactoryGirl.create :host, type: 'switch' }

      before { get '/api/hosts?type=apc' }

      it 'records' do
        expect(response).to  have_http_status(:success)

        expect(api_response.map {|r| r[:id] }).to be_include(apc.id)
        expect(api_response.map {|r| r[:id] }).to_not be_include(switch.id)
      end
    end

    describe 'filter by location' do
      let!(:dc1_rack1) { FactoryGirl.create :rack_cabinet, location: 'dc1' }
      let!(:dc1_rack2) { FactoryGirl.create :rack_cabinet, location: 'dc1' }
      let!(:dc2_rack1) { FactoryGirl.create :rack_cabinet, location: 'dc2' }
      let!(:dc1_host1) { FactoryGirl.create :host, rack: dc1_rack1 }
      let!(:dc1_host2) { FactoryGirl.create :host, rack: dc1_rack2 }
      let!(:dc2_host1) { FactoryGirl.create :host, rack: dc2_rack1 }

      before { get '/api/hosts?location=dc1' }

      it 'have fields and records' do
        expect(response).to  have_http_status(:success)

        expect(api_response.map {|r| r[:id] }).to be_include(dc1_host1.id)
        expect(api_response.map {|r| r[:id] }).to be_include(dc1_host2.id)
        expect(api_response.map {|r| r[:id] }).to_not be_include(dc2_host1.id)
      end
    end

    describe 'combinate type filter and location filter' do
      let!(:dc1_rack) { FactoryGirl.create :rack_cabinet, location: 'dc1' }
      let!(:dc2_rack) { FactoryGirl.create :rack_cabinet, location: 'dc2' }

      let!(:apc) { FactoryGirl.create :host, type: 'apc', rack: dc1_rack }
      let!(:apc_dc2) { FactoryGirl.create :host, type: 'apc', rack: dc2_rack }
      let!(:switch) { FactoryGirl.create :host, type: 'switch', rack: dc1_rack }

      before { get '/api/hosts?type=apc&location=dc1' }

      it 'records' do
        expect(response).to  have_http_status(:success)

        expect(api_response.map {|r| r[:id] }).to be_include(apc.id)
        expect(api_response.map {|r| r[:id] }).to_not be_include(apc_dc2.id)
        expect(api_response.map {|r| r[:id] }).to_not be_include(switch.id)
      end
    end
  end

  describe :create do
    it 'new hosts ' do
      post '/api/hosts', { name: 'test', type: 'server' }

      expect(response).to have_http_status(:created)
      expect(api_response[:name]).to eq 'test'
      expect(api_response[:type]).to eq 'server'
    end
  end

  describe :show do
    let!(:host) { FactoryGirl.create(:host) }

    it 'host' do
      get "/api/hosts/#{ host.id }"

      expect(response).to have_http_status(:success)
      expect(api_response[:id]).to eq host.id
    end
  end

  describe :update do
    let!(:host) { FactoryGirl.create(:host, name: 'old') }

    it 'host name' do
      put "/api/hosts/#{ host.id }", { name: 'new' }

      expect(response).to have_http_status(:success)
      expect(api_response[:name]).to eq 'new'
      expect(api_response[:type]).to eq host.type
    end
  end

  describe :destroy do
    let!(:host) { FactoryGirl.create(:host) }

    it 'host' do
      delete "/api/hosts/#{ host.id }"

      expect(response).to have_http_status(:success)

      expect(Host.find_by(id: host)).to_not be
    end
  end
end
