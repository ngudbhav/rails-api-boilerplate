RSpec.describe ApplicationRecord, type: :model do
  it 'is an abstract class' do
    expect(described_class.abstract_class?).to be true
  end

  it 'does not has a table name' do
    expect(described_class.table_name).to be_nil
  end

  it 'has a primary key' do
    expect(described_class.primary_key).to eq('id')
  end

  it 'is not instantiated directly' do
    expect { described_class.new }.to raise_error(NotImplementedError)
  end

  it 'has discard module included' do
    expect(described_class.included_modules).to include(Discard::Model)
  end
end
