RSpec.describe Users::ProfilesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before do
    auth_as user
  end
  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['user']['id']).to eq(user.id)
    end
  end

  describe 'PATCH #update' do
    let(:valid_params) do
      {
        user: {
          name: 'Updated Name'
        }
      }
    end
    it 'updates the user profile' do
      patch :update, params: valid_params
      expect(response).to have_http_status(:ok)
      user.reload
      expect(user.name).to eq('Updated Name')
    end
  end
end
