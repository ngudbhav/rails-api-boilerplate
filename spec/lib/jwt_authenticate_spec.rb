RSpec.describe JwtAuthenticate do
  describe '.encode' do
    let(:payload) { { user_id: 1 } }
    let(:token) { described_class.encode(payload) }

    it 'encodes the payload into a JWT token' do
      expect(token).to be_a(String)
      expect(token).not_to be_empty
    end

    it 'includes the user_id in the payload' do
      decoded = described_class.decode(token)
      expect(decoded[:user_id]).to eq(1)
    end

    it 'sets the expiration time' do
      decoded = described_class.decode(token)
      expect(decoded[:exp]).to be_present
    end
  end

  describe '.decode' do
    let(:payload) { { user_id: 1 } }
    let(:token) { described_class.encode(payload) }

    it 'decodes a valid JWT token' do
      decoded = described_class.decode(token)
      expect(decoded[:user_id]).to eq(1)
    end

    it 'returns an empty hash for an invalid token' do
      invalid_token = 'invalid.token.string'
      decoded = described_class.decode(invalid_token)
      expect(decoded).to eq({})
    end
  end
end
