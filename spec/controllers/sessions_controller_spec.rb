RSpec.describe SessionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'POST #create' do
    context 'with phone/OTP' do
      let(:user_verification) { FactoryBot.create(:user_verification, user: user) }

      context 'with valid credentials' do
        it 'creates a new session' do
          post :create, params: { phone_number: user.phone_number, otp: user_verification.verification_code }
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)['token']).to be_present
        end
      end

      context 'with invalid OTP' do
        it 'returns bad_request' do
          post :create, params: { phone_number: user.phone_number, otp: "x" }
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'with email/password' do
      let(:user) { FactoryBot.create(:user, :with_email_auth) }

      context 'with valid credentials' do
        it 'creates a new session' do
          post :create, params: { email_address: user.email_address, password: 'password123456' }
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)['token']).to be_present
        end
      end

      context 'with invalid password' do
        it 'returns bad_request' do
          post :create, params: { email_address: user.email_address, password: 'wrongpassword' }
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'with unknown email' do
        it 'returns unauthorized' do
          post :create, params: { email_address: 'nobody@example.com', password: 'password123456' }
          expect(response).to have_http_status(:unauthorized)
        end
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
