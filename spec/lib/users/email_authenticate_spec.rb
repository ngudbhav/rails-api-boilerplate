RSpec.describe Users::EmailAuthenticate do
  let(:password) { 'password123456' }
  let(:user) { FactoryBot.create(:user, :with_email_auth, password: password, password_confirmation: password) }

  describe '#authenticate_by_email' do
    context 'with valid password' do
      it 'returns the user' do
        expect(user.authenticate_by_email(password)).to eq(user)
      end
    end

    context 'with invalid password' do
      it 'returns false' do
        expect(user.authenticate_by_email('wrongpassword')).to eq(false)
      end
    end
  end
end
