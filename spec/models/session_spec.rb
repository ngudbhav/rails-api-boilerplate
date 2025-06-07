RSpec.describe Session, type: :model do
  context 'When creating a new session' do
    let(:session) { FactoryBot.create(:session) }

    it 'should assign a random session_id' do
      expect(session.session_id).to be_present
      expect(session.session_id).to match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/)
    end
  end
end
