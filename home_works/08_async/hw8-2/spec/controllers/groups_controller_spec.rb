require 'rails_helper'

RSpec.describe GroupsController, type: :controller do  
   describe 'POST #create' do
    it 'creates group' do
      post :create, params: { group: { name: 'foo' } }
      expect(Group.first).to have_attributes(name: 'foo')
    end
    it 'returns group attributes' do
      post :create, params: { group: { name: 'foo' } }
      expect(JSON.parse(response.body).keys).to contain_exactly('id', 'name')
    end
  end  

  describe 'POST #delete' do
    it 'delete group' do
      group = create(:group)
      delete :destroy, params: {id: group.id}
      expect(response).to have_http_status(204)
      expect(Group.find_by_id(id: group.id)).to eq(nil)
    end
  end

  describe 'GET #index' do
    before(:all) do
        create_list(:group, 5)
    end
    after(:all) do
        Group.destroy_all
    end
    it 'returns a 200 status code' do
        get :index
        # expect(response.status).to eq(200)
        expect(response).to have_http_status(:ok)
    end
    it 'returns an array body' do
        get :index
        expect(JSON.parse(response.body)).to be_instance_of(Array)
    end
    it 'returns group attributes' do
        get :index
        groups = JSON.parse(response.body)
        expect(groups[0].keys).to contain_exactly('id', 'name')
    end
    it 'filter by name' do
        get :index, params: { name: 'group_1' }
        expect(JSON.parse(response.body).count).to eq(1)
    end
    it 'list of group format' do
        get :index
        expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end
end