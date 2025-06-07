RSpec.describe User, type: :model do
  describe '#phone_number' do
    context 'when phone number is invalid' do
      it 'raises an error' do
        user = FactoryBot.build(:user, phone_number: 'invalid_phone')
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid, /Phone number is invalid/)
      end
    end
  end
end
