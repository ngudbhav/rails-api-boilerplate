RSpec.describe Credentials do
  describe '#get' do
    let(:credentials) { { "api" => "12345", "nested" => { "key" => "67890" } } }

    before do
      allow(Rails.application).to receive(:credentials).and_return(credentials)
    end

    it 'returns the value for a top-level key' do
      expect(Credentials.get("api")).to eq("12345")
    end

    it 'returns the value for a nested key' do
      expect(Credentials.get("nested_key")).to eq("67890")
    end

    it 'returns an empty string for a non-existent key' do
      expect(Credentials.get("non_existent_key")).to eq("")
    end

    it 'returns an empty string when no key is provided' do
      expect(Credentials.get).to eq("")
    end

    it 'returns the environment variable if it exists' do
      allow(ENV).to receive(:key?).with("ENV_VAR").and_return(true)
      allow(ENV).to receive(:[]).with("ENV_VAR").and_return("env_value")
      expect(Credentials.get("ENV_VAR")).to eq("env_value")
    end
  end
end
