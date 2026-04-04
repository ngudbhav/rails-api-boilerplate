RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with phone number' do
      let(:user_params) do
        { user: { phone_number: '919000000000' } }
      end

      context 'when not rate limited' do
        context 'with valid parameters' do
          it 'creates a new user' do
            expect {
              post :create, params: user_params
            }.to change(User, :count).by(1)
            expect(response).to have_http_status(:ok)
          end
        end

        context 'with invalid parameters' do
          before do
            user_params[:user][:phone_number] = '91900000000'
          end

          it 'does not create a new user' do
            expect {
              post :create, params: user_params
            }.not_to change(User, :count)
            expect(response).to have_http_status(:bad_request)
          end
        end
      end

      context 'when rate limited' do
        it 'returns a too many requests status' do
          20.times do
            post :create, params: user_params
          end
          expect(response).to have_http_status(:too_many_requests)
          expect(response.body).to include("Try again later.")
        end
        after do
          Rails.cache.clear
        end
      end
    end

    context 'with email and password' do
      let(:user_params) do
        { user: { email_address: Faker::Internet.email, password: 'password123456', password_confirmation: 'password123456' } }
      end

      context 'with valid parameters' do
        it 'creates a new user' do
          expect {
            post :create, params: user_params
          }.to change(User, :count).by(1)
          expect(response).to have_http_status(:ok)
        end
      end

      context 'with password too short' do
        it 'does not create a new user' do
          expect {
            post :create, params: { user: { email_address: Faker::Internet.email, password: 'short', password_confirmation: 'short' } }
          }.not_to change(User, :count)
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'without a password' do
        it 'does not create a new user' do
          expect {
            post :create, params: { user: { email_address: Faker::Internet.email } }
          }.not_to change(User, :count)
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end
