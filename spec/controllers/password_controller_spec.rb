RSpec.describe PasswordsController, type: :controller do
  describe 'PATCH #update' do
    let(:user) { FactoryBot.create(:user) }
    let(:password) { Faker::Internet.password }
    let(:valid_params) do
      {
        user: {
          email: user.email_address,
          password: password,
          password_confirmation: password
        },
        token: Faker::Crypto.md5
      }
    end

    context 'with valid token' do
      before do
        allow(User).to receive(:find_by_password_reset_token!).and_return(user)
      end
      context 'with valid parameters' do
        it 'updates the user password' do
          post :update, params: valid_params
          expect(response).to have_http_status(:ok)
          expect(user.reload.password_digest).to be_present
        end
      end

      context 'with valid but different passwords' do
        let(:invalid_params) do
          {
            user: {
              email: user.email_address,
              password: password,
              password_confirmation: Faker::Internet.password
            },
            token: Faker::Crypto.md5
          }
        end

        it 'does not update the user password' do
          post :update, params: invalid_params
          expect(response).to have_http_status(:not_acceptable)
        end
      end
    end

    context 'with invalid token' do
      before do
        allow(User).to receive(:find_by_password_reset_token!).and_raise(ActiveSupport::MessageVerifier::InvalidSignature)
      end
      let(:invalid_params) do
        {
          user: {
            email: user.email_address,
            password: password,
            password_confirmation: password
          },
          token: Faker::Crypto.md5
        }
      end

      it 'returns an error' do
        post :update, params: invalid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:valid_params) do
      {
        email_address: user.email_address
      }
    end

    context 'when the user exists' do
      it 'sends a password reset email' do
        expect {
          post :create, params: valid_params
        }.to have_enqueued_email(PasswordsMailer, :reset).with(user)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user does not exist' do
      it 'does not send an email' do
        expect {
          post :create, params: { email_address: '' }
        }.not_to change { ActionMailer::Base.deliveries.count }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
