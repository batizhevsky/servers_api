require 'rails_helper'

RSpec.describe Api::RacksController do

  describe 'index' do
    let!(:racks) { FactoryGirl.create_list :rack_cabinet, 5 }

    it 'show list of racks' do
      get '/api/racks'

      expect(response).to have_http_status(:success)

      expect(api_response.sample).to have_key(:name)
      expect(api_response.sample).to have_key(:location)
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

  describe :update do
    let!(:rack) { FactoryGirl.create(:rack_cabinet, name: 'old', location: 'dc2') }

    it 'create new rack ' do
      put "/api/racks/#{ rack.id }", name: 'new rack', location: 'dc1'

      expect(response).to have_http_status(:success)
      expect(api_response[:name]).to eq 'test rack'
      expect(api_response[:locatione]).to eq 'dc2'
    end
  end

  describe :destroy do
    let!(:rack) { FactoryGirl.create(:rack_cabinet, name: 'old', location: 'dc2') }

    it 'create new rack ' do
      delete "/api/racks/#{ rack.id }"

      expect(response).to have_http_status(:success)

      expect(RackCabinet.find_by(id: rack)).to_not be
    end
  end
end
