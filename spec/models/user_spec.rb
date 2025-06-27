# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  discarded_at    :datetime
#  email_address   :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  phone_number    :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_discarded_at   (discarded_at)
#  index_users_on_email_address  (email_address) UNIQUE
#  index_users_on_phone_number   (phone_number) UNIQUE
#
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
