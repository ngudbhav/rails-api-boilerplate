RSpec.describe SessionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  describe 'POST #create' do
    let(:user_verification) { FactoryBot.create(:user_verification, user: user) }

    context 'with valid credentials' do
      it 'creates a new session' do
        post :create, params: { phone_number: user.phone_number, otp: user_verification.verification_code }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['token']).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized status' do
        post :create, params: { phone_number: user.phone_number, otp: "x" }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      auth_as(user)
    end

    it 'deletes the session' do
      delete :destroy
      expect(response).to have_http_status(:ok)
    end
  end
end
